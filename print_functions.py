from clingo import Model, SymbolType, Function
import sys
from collections import defaultdict

# specific imports for the geometric displayer
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Rectangle
from matplotlib.lines import Line2D
import matplotlib.colors as mcolors
from matplotlib.widgets import Button
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
import atexit
import time


GEOMETRIC_SORT_PREDICATES = ("point", "point3", "rect", "line", "box")
# Temporal operators are useful internally, but they are not spatial facts the user
# wants to see in each state header. We hide them when printing true atoms.
TEMPORAL_OPERATOR_PREDICATES = ("__initial", "__next", "__prev", "__eventually")
DEFAULT_DISPLAY_TIME = 7
DEFAULT_SPACE_LIMITS = {"xmin": 0, "xmax": 10, "ymin": 0, "ymax": 10, "zmin": 0, "zmax": 10}
SPACE_BORDER_COLOR = "grey"
SPACE_BORDER_WIDTH = 2.0
SPACE_BORDER_ALPHA = 0.8  # sets the opacity of the border, max is 1.0 

# Add object names to these lists to force display colors in matplotlib.
# Matching is substring-based, so "bank" also matches compound names like
# "bank(near)" and "bank(far)".
BLUE_OBJECT_NAMES = ["river"]
GREEN_OBJECT_NAMES = ["bank"]
BROWN_OBJECT_NAMES = ["boat"]

SPECIFIC_OBJECT_COLOR_GROUPS = [
    (BLUE_OBJECT_NAMES, "tab:blue"),
    (GREEN_OBJECT_NAMES, "tab:green"),
    (BROWN_OBJECT_NAMES, "saddlebrown"),
]

BLUE = "\033[94m"
GREEN = "\033[92m"
RED = "\033[91m"
RESET = "\033[0m"
YELLOW = "\033[93m"
GREY = "\033[90m"

########################################################
# Collect and print the solutions in the console
########################################################
def print_val4diag_table(val4diag, state=None):
    
    rows = []
    for sort, objs in val4diag.items():
        for name, obj in objs.items():  
            params = ", ".join(
                f"{param}={obj[param]}"
                for param in sorted(obj)
            )
            rows.append((sort, name, params))

    if not rows:
        return

    w_sort = max(len("sort"), max(len(r[0]) for r in rows))  # compute column width for the sort column
    w_name = max(len("name"), max(len(str(r[1])) for r in rows))

    rows.sort(key=lambda row: (row[0], str(row[1])))  # sort the rows by sort, and within each sort by name

    # print the table
    if state is not None:
        print(BLUE + f"State {state}:" + RESET)
    print(BLUE + f"{'sort':<{w_sort}} | {'name':<{w_name}} | params" + RESET)
    print(BLUE + "-" * (w_sort + 3 + w_name + 3 + 20) + RESET)

    for sort, name, params in rows:
        print(BLUE + f"{sort:<{w_sort}} | {name:<{w_name}} | {params}" + RESET)



class GeometricDisplayer:
    def __init__(self, xmin, xmax, ymin, ymax, zmin, zmax, display_time=DEFAULT_DISPLAY_TIME):
        """
        Initialize the displayer with plot limits.
        
        Args:
            xmin (int): Minimum x-axis value
            xmax (int): Maximum x-axis value
            ymin (int): Minimum y-axis value
            ymax (int): Maximum y-axis value
            zmin (int): Minimum z-axis value used for 3D scenes
            zmax (int): Maximum z-axis value used for 3D scenes
            display_time (float): Time in seconds before closing displayed plots
        """
        self.xmin = xmin
        self.xmax = xmax
        self.ymin = ymin
        self.ymax = ymax
        self.zmin = zmin
        self.zmax = zmax
        self.max_figures = 8
        self.display_time = display_time
        
        # Distinct colors optimized for visibility and differentiation
        self.color_sequence = [
            '#ADD8E6',  # Light blue
            '#F0E68C',  # Khaki
            '#98FB98',  # Pale green
            '#FFB6C1',  # Light pink
            '#DDA0DD',  # Plum
            '#E6E6FA',  # Lavender
            '#FFA07A',  # Light salmon
            '#B0E0E6',  # Powder blue
            '#D8BFD8',  # Thistle
            '#FAFAD2',  # Light goldenrod
        ]
            
    def _get_subplot_size(self, num_solutions):
        """Calculate subplot size based on number of solutions."""
        if num_solutions == 1:
            return 6.0    # Single plot
        elif num_solutions == 2:
            return 5.0    # Two plots
        elif num_solutions <= 4:
            return 4.0    # 3-4 plots
        else:
            return 4.0    # 5+ plots
            
    def _get_color_from_name(self, name_obj, rect_index):
        """Get RGBA color from object name or default sequence."""
        # First check project-specific object groups. This is useful for objects
        # whose semantic role should always have the same color, independently
        # of the order in which models/states are displayed.
        for object_names, color in SPECIFIC_OBJECT_COLOR_GROUPS:
            if any(object_name in name_obj for object_name in object_names):
                return mcolors.to_rgba(color, alpha=0.8)

        # Then check if there's a CSS color name in the object name.
        found_colors = []
        for color_name in mcolors.CSS4_COLORS:
            if color_name in name_obj:
                found_colors.append(color_name)
        
        found_colors.sort(key=len, reverse=True)
        if found_colors:
            return mcolors.to_rgba(found_colors[0], alpha=0.8)
            
        # If no color in name, use sequence
        color_idx = rect_index % len(self.color_sequence)
        return mcolors.to_rgba(self.color_sequence[color_idx], alpha=0.8)

    def _setup_subplot(self, ax, index, is_3d=False, title=None):
        """Setup a single subplot with proper settings."""
        ax.grid(True)
        # The spatial frame is fixed from constants for the whole model/trace.
        # Do not derive limits from the objects in the current state, otherwise
        # the apparent coordinate system can shift while animating.
        ax.set_xlim(self.xmin - 1, self.xmax + 1)
        ax.set_ylim(self.ymin - 1, self.ymax + 1)
        # Matplotlib may otherwise autoscale after patches/text are redrawn.
        # Keeping autoscale off is important for a stable animation frame.
        ax.set_autoscale_on(False)
        ax.set_title(title or f'Solution {index + 1}')
        if is_3d:
            ax.set_zlim(self.zmin - 1, self.zmax + 1)
            ax.set_xlabel("x")
            ax.set_ylabel("y")
            ax.set_zlabel("z")
            # Keep physical proportions aligned with domain sizes.
            if hasattr(ax, "set_box_aspect"):
                ax.set_box_aspect((
                    max(self.xmax - self.xmin, 1),
                    max(self.ymax - self.ymin, 1),
                    max(self.zmax - self.zmin, 1),
                ))
            self._draw_axes_arrows_3d(ax)
        else:
            # Use a fixed axes box for equal scaling. This avoids tiny layout
            # changes between states when the drawn objects or labels vary.
            ax.set_aspect("equal", adjustable="box")
            self._draw_space_border(ax)

    def _draw_space_border(self, ax):
        """Outline the spatial domain without hiding objects placed on it."""
        # Drawn unfilled and translucent so points/rects lying exactly on the
        # border stay readable. A low zorder keeps it behind every object.
        border = Rectangle(
            (self.xmin, self.ymin),
            self.xmax - self.xmin,
            self.ymax - self.ymin,
            fill=False,
            edgecolor=SPACE_BORDER_COLOR,
            linewidth=SPACE_BORDER_WIDTH,
            alpha=SPACE_BORDER_ALPHA,
            zorder=0,
        )
        ax.add_patch(border)

    def _draw_axes_arrows_3d(self, ax):
        """Draw simple domain arrows from the lower corner."""
        ax.quiver(self.xmin, self.ymin, self.zmin, self.xmax - self.xmin, 0, 0, color='tab:red', arrow_length_ratio=0.06)
        ax.quiver(self.xmin, self.ymin, self.zmin, 0, self.ymax - self.ymin, 0, color='tab:green', arrow_length_ratio=0.06)
        ax.quiver(self.xmin, self.ymin, self.zmin, 0, 0, self.zmax - self.zmin, color='tab:blue', arrow_length_ratio=0.06)
        ax.text(self.xmax, self.ymin, self.zmin, " x")
        ax.text(self.xmin, self.ymax, self.zmin, " y")
        ax.text(self.xmin, self.ymin, self.zmax, " z")

    def _draw_points(self, ax, points_data):
        """Draw points and their labels on a subplot."""
        for name, point in points_data.items():
            x, y = point['x'], point['y']
            
            point_circle = Circle((x, y), 0.1, color='black')
            ax.add_patch(point_circle)
            
            offset_x = -0.3
            offset_y = 0.2
            ax.annotate(name, (x, y), xytext=(x + offset_x, y + offset_y), 
                       annotation_clip=False)

    def _draw_points3(self, ax, points3_data):
        """Draw 3D points and labels on a subplot."""
        for name, point in points3_data.items():
            x, y, z = point['x'], point['y'], point['z']
            ax.scatter([x], [y], [z], color='black', s=20)
            ax.text(x, y, z, f" {name}")

    def _draw_lines(self, ax, lines_data):
        """Draw lines and their labels on a subplot."""
        for name, line in lines_data.items():
            xs, ys = line['xstart'], line['ystart']
            xe, ye = line['xend'], line['yend']
            
            line_obj = Line2D([xs, xe], [ys, ye], color='black', lw=2)
            ax.add_line(line_obj)
            
            mid_x = (xs + xe) / 2
            mid_y = (ys + ye) / 2
            if name == "ground":
                ax.annotate(name, (mid_x, mid_y), xytext=(-10, -10), 
                           textcoords="offset points", ha='center')
            else:
                ax.annotate(name, (mid_x, mid_y), xytext=(-10, 10), 
                       textcoords="offset points", ha='center')

    def _draw_lines_3d(self, ax, lines_data):
        """Draw 2D lines projected on the lower z plane in a 3D subplot."""
        for name, line in lines_data.items():
            xs, ys = line['xstart'], line['ystart']
            xe, ye = line['xend'], line['yend']
            ax.plot([xs, xe], [ys, ye], [self.zmin, self.zmin], color='black', lw=2)
            ax.text((xs + xe) / 2, (ys + ye) / 2, self.zmin, f" {name}")

    def _draw_rects(self, ax, rects_data):
        """Draw rects and their labels on a subplot."""
        #print("rects_data: ", rects_data)
        # Sort rects by area in descending order
        # self._draw_rects(ax, solution['rects'])
        sorted_rects = sorted(
            enumerate(rects_data.items()),
            key=lambda x: x[1][1]['width'] * x[1][1]['height'],
            reverse=True
        )
        
        for orig_idx, (name, rect) in sorted_rects:
            x, y = rect['left_side'], rect['bottom']
            w, h = rect['width'], rect['height']
            
            # Get color with original index to maintain color consistency
            color = self._get_color_from_name(name, orig_idx)
            
            rect = Rectangle((x, y), w, h, fill=True, 
                               edgecolor="black",
                               facecolor=color,
                               linewidth=0.5)  # Thin black border
            ax.add_patch(rect)
            
            # Label slightly above the top side, centered
            ax.annotate(name, (x + w / 2, y + h),
                       xytext=(x + w / 2, y + h + 0.10),
                       ha='center', va='bottom',
                       annotation_clip=False)

    def _draw_rects_3d(self, ax, rects_data):
        """Draw 2D rects as lower z-plane wireframes."""
        for name, rect in rects_data.items():
            x, y = rect['left_side'], rect['bottom']
            w, h = rect['width'], rect['height']
            x2, y2 = x + w, y + h
            # rectangle perimeter on the lower z plane
            xs = [x, x2, x2, x, x]
            ys = [y, y, y2, y2, y]
            zs = [self.zmin] * 5
            ax.plot(xs, ys, zs, color='black', lw=1.2)
            ax.text(x, y, self.zmin, f" {name}")

    def _draw_boxes_3d(self, ax, boxes_data):
        """Draw 3D boxes with colored faces and black edges."""
        # V000..V111 are the 8 box corners (min/max x, y, z). They are needed to define each box face for 
        # filled 3D rendering with Poly3DCollection, which is why this style is used instead of simple edge-only plotting.
        for idx, (name, box) in enumerate(boxes_data.items()):
            x0, y0, z0 = box["xmin"], box["ymin"], box["zmin"]
            x1, y1, z1 = box["xmax"], box["ymax"], box["zmax"]
            color = self._get_color_from_name(name, idx)

            # 8 vertices
            v000 = (x0, y0, z0)
            v100 = (x1, y0, z0)
            v110 = (x1, y1, z0)
            v010 = (x0, y1, z0)
            v001 = (x0, y0, z1)
            v101 = (x1, y0, z1)
            v111 = (x1, y1, z1)
            v011 = (x0, y1, z1)

            faces = [
                [v000, v100, v110, v010],  # bottom
                [v001, v101, v111, v011],  # top
                [v000, v100, v101, v001],  # front
                [v010, v110, v111, v011],  # back
                [v000, v010, v011, v001],  # left
                [v100, v110, v111, v101],  # right
            ]

            poly = Poly3DCollection(
                faces,
                facecolors=color,
                edgecolors="black",
                linewidths=0.8,
            )
            ax.add_collection3d(poly)
            ax.text(x0, y0, z0, f" {name}")

    def _has_3d_data(self, val4diags):
        """Return True when at least one solution has 3D objects."""
        return any(solution.get('point3') or solution.get('box') for solution in val4diags)

    def _has_required_params(self, val4diag):
        """Return False when a drawable object misses coordinates needed by matplotlib."""
        # The displayer consumes the normalized val4diag representation, not
        # raw solver symbols. Each object sort needs a minimal set of numeric
        # parameters to be drawable. For rectangles, right_side/top may be
        # derived in the encoding, but the printer draws from left/bottom/width/height.
        required_params_by_sort = {
            "point": ("x", "y"),
            "point3": ("x", "y", "z"),
            "rect": ("left_side", "bottom", "width", "height"),
            "line": ("xstart", "ystart", "xend", "yend"),
            "box": ("xmin", "xmax", "ymin", "ymax", "zmin", "zmax"),
        }
        for sort, required_params in required_params_by_sort.items():
            for obj in val4diag.get(sort, {}).values():
                if any(param not in obj for param in required_params):
                    return False
        return True

    def has_required_params(self, val4diags):
        """Return True when all diagrams have the coordinates required for drawing."""
        return all(self._has_required_params(val4diag) for val4diag in val4diags)

    def _get_state_display_time(self, max_states):
        """Use display_time as the approximate duration of a full trace animation."""
        # display_time is interpreted as the total lifetime of the animation,
        # so each frame receives a fraction of it. A small lower bound keeps the
        # GUI event loop responsive and makes very long traces still visible.
        return max(0.25, self.display_time / max(max_states, 1))

    def _wait_while_respecting_pause(self, fig, seconds, animation_state):
        """Wait between frames while keeping the GUI responsive to Pause/Play."""
        start = time.monotonic()
        while True:
            fig.canvas.flush_events()

            if animation_state["paused"]:
                time.sleep(0.05)
                start = time.monotonic()
                continue

            if time.monotonic() - start >= seconds:
                return

            time.sleep(0.05)

    def _draw_solution(self, ax, solution, is_3d=False):
        """Draw one static state on an already configured axis."""
        # This function is intentionally stateless: the caller is responsible
        # for clearing/configuring the axis. That lets the same drawing code be
        # reused for static models and for each frame of temporal traces.
        if is_3d:
            self._draw_boxes_3d(ax, solution.get('box', {}))
            self._draw_points3(ax, solution.get('point3', {}))
            self._draw_points3(
                ax,
                {
                    name: {'x': point['x'], 'y': point['y'], 'z': self.zmin}
                    for name, point in solution.get('point', {}).items()
                }
            )
            self._draw_lines_3d(ax, solution.get('line', {}))
        else:
            self._draw_rects(ax, solution.get('rect', {}))
            self._draw_points(ax, solution.get('point', {}))
            self._draw_lines(ax, solution.get('line', {}))

    def _calculate_grid_size(self, num_solutions):
        """Calculate the grid size based on number of solutions."""
        if num_solutions <= 2:
            return 1, min(2, num_solutions)
        elif num_solutions <= 4:
            return 2, 2
        elif num_solutions <= 6:
            return 2, 3
        else:  # 7+ solutions/states
            cols = 4
            rows = (num_solutions + cols - 1) // cols
            return rows, cols

    # This is the main function 
    def display(self, val4diags):
        """
        Display geometric solutions in a grid layout.
        
        Args:
            val4diags (list): List of dictionaries containing geometric objects
        """
        #print(val4diags) # out: [{'rect': {'r1': {'x': 0, 'y': 0, 'w': 1, 'h': 1}}, 'point': {'p1': {'x': 0, 'y': 0}}, 'line': {'l1': {'xstart': 0, 'ystart': 0, 'xend': 1, 'yend': 1}}}]
        num_solutions = min(len(val4diags), self.max_figures) 
        if num_solutions == 0:
            return
        
        # Calculate grid dimensions
        rows, cols = self._calculate_grid_size(num_solutions)
        
        # Get appropriate subplot size
        subplot_size = self._get_subplot_size(num_solutions)
        use_3d = self._has_3d_data(val4diags[:num_solutions])
        
        # Create figure with calculated dimensions
        fig = plt.figure(figsize=(subplot_size * cols, subplot_size * rows))
        
        # Create and populate each subplot
        for idx, solution in enumerate(val4diags[:num_solutions]):
            if use_3d:
                ax = fig.add_subplot(rows, cols, idx + 1, projection='3d')
                self._setup_subplot(ax, idx, is_3d=True)
                #self._draw_rects_3d(ax, solution.get('rect', {}))
                self._draw_boxes_3d(ax, solution.get('box', {}))
                self._draw_points3(ax, solution.get('point3', {}))
                # Keep 2D objects visible in mixed scenes.
                self._draw_points3(
                    ax,
                    {
                        name: {'x': point['x'], 'y': point['y'], 'z': self.zmin}
                        for name, point in solution.get('point', {}).items()
                    }
                )
                self._draw_lines_3d(ax, solution.get('line', {}))
            else:
                ax = fig.add_subplot(rows, cols, idx + 1)
                self._setup_subplot(ax, idx, is_3d=False)
                # Draw rects first (sorted by area), then points and lines
                self._draw_rects(ax, solution.get('rect', {}))
                self._draw_points(ax, solution.get('point', {}))
                self._draw_lines(ax, solution.get('line', {}))
        
        # Adjust layout to prevent overlap
        plt.tight_layout()
        
        # Show plot and set up auto-close
        plt.show(block=False) # block=False allows the code to continue running
        plt.pause(self.display_time)
        plt.close()

    def display_trace(self, trace_val4diag, trace_index):
        """
        Display one temporal model by animating its states in a single figure.

        Args:
            trace_val4diag (dict): Mapping from state number to geometric objects.
            trace_index (int): Zero-based dynamic model index.
        """
        # Kept as a convenience wrapper for callers that display one trace.
        # The implementation delegates to display_traces so one-trace and
        # many-trace animations follow exactly the same code path.
        self.display_traces([trace_val4diag])

    def display_traces(self, trace4diags):
        """
        Display temporal models as one dynamic grid, one subplot per trace.
        """
        # A trace is represented as {state_number: val4diag}. The outer list
        # contains alternative dynamic models. We cap it at max_figures, matching
        # the old static display behavior of showing at most eight models.
        traces = trace4diags[:self.max_figures]
        if not traces:
            return

        max_states = max(len(trace) for trace in traces)
        state_display_time = self._get_state_display_time(max_states)
        num_traces = len(traces)
        rows, cols = self._calculate_grid_size(num_traces)
        subplot_size = self._get_subplot_size(num_traces)
        fig = plt.figure(figsize=(subplot_size * cols, subplot_size * rows))
        # Do not call tight_layout inside the animation loop. tight_layout
        # recomputes axes boxes from titles/labels at every state, which made
        # the coordinate frame visibly "move" by a few pixels. Fixed margins
        # keep every subplot box stable for the whole trace.
        fig.subplots_adjust(left=0.06, right=0.98, bottom=0.12, top=0.92, wspace=0.25, hspace=0.35)
        animation_state = {"paused": False}
        pause_button_ax = fig.add_axes([0.45, 0.03, 0.10, 0.045])
        pause_button = Button(pause_button_ax, "Pause")

        def toggle_pause(_event):
            animation_state["paused"] = not animation_state["paused"]
            pause_button.label.set_text("Play" if animation_state["paused"] else "Pause")
            fig.canvas.draw_idle()

        pause_button.on_clicked(toggle_pause)
        axes = []

        for trace_index, trace_val4diag in enumerate(traces):
            states = sorted(trace_val4diag)
            val4diags = [trace_val4diag[state] for state in states]
            use_3d = self._has_3d_data(val4diags)
            # Each trace gets one persistent axis. During animation we clear
            # and redraw its artists, but we do not recreate the figure/window.
            ax = (
                fig.add_subplot(rows, cols, trace_index + 1, projection='3d')
                if use_3d
                else fig.add_subplot(rows, cols, trace_index + 1)
            )
            axes.append((ax, trace_index, states, trace_val4diag, use_3d))

        # Show the window once. Repeated pyplot show/pause calls can bring the
        # matplotlib window back to the foreground on some backends.
        plt.show(block=False)
        for state_index in range(max_states):
            for ax, trace_index, states, trace_val4diag, use_3d in axes:
                if not states:
                    continue
                # Keep shorter traces visible on their last state while longer traces continue.
                state = states[min(state_index, len(states) - 1)]
                ax.clear()
                # Clearing removes limits/aspect/grid, so always restore the
                # stable coordinate frame before drawing the next state's objects.
                self._setup_subplot(
                    ax,
                    trace_index,
                    is_3d=use_3d,
                    title=f"Trace {trace_index + 1} - State {state}",
                )
                self._draw_solution(ax, trace_val4diag[state], is_3d=use_3d)
            # Draw directly on the existing canvas. This updates the animation
            # without repeatedly asking pyplot to show/raise the window.
            fig.canvas.draw()
            fig.canvas.flush_events()
            self._wait_while_respecting_pause(fig, state_display_time, animation_state)

        plt.close(fig)




########################################################
# Table printer for the spatial logic
# ########################################################


class PrinterManager:
    def __init__(self):
        self.val4diags = []
        self.trace4diags = []
        self.space_limits = DEFAULT_SPACE_LIMITS.copy()
        self.display_time = DEFAULT_DISPLAY_TIME
        self.use_mpl_display = False
        self.max_figures = 8

    def format_shown_formula(self, formula):
        """Format a formula shown through true/1 or true/2 for console output."""
        # The state header should show user-relevant atoms: spatial relations
        # like left/on and ordinary ASP atoms. It should not repeat sort
        # declarations, df/eq bookkeeping, or temporal operators.
        if (
            formula.name in ["__df", "__eq"]
            or formula.name in GEOMETRIC_SORT_PREDICATES
            or formula.name in TEMPORAL_OPERATOR_PREDICATES
        ):
            return None
        if formula.name.startswith("__"):
            return GREEN + str(formula).replace("__","") + RESET
        return RESET + str(formula) + RESET

    def get_display_time(self, system):
        value = system.constants.get("display_time", DEFAULT_DISPLAY_TIME)
        try:
            return float(value)
        except (TypeError, ValueError):
            print(RED + f"WARNING: Invalid display_time={value}, using {DEFAULT_DISPLAY_TIME} seconds." + RESET)
            return DEFAULT_DISPLAY_TIME

    def set_space_limits_from_constants(self, system):
        self.space_limits = DEFAULT_SPACE_LIMITS.copy()
        for name, default in DEFAULT_SPACE_LIMITS.items():
            value = system.constants.get(name, default)
            try:
                self.space_limits[name] = int(value)
            except (TypeError, ValueError):
                print(RED + f"WARNING: Invalid {name}={value}, using {default}." + RESET)

        if self.space_limits["xmin"] > self.space_limits["xmax"]:
            print(RED + "WARNING: xmin is greater than xmax, swapping them for display." + RESET)
            self.space_limits["xmin"], self.space_limits["xmax"] = self.space_limits["xmax"], self.space_limits["xmin"]
        if self.space_limits["ymin"] > self.space_limits["ymax"]:
            print(RED + "WARNING: ymin is greater than ymax, swapping them for display." + RESET)
            self.space_limits["ymin"], self.space_limits["ymax"] = self.space_limits["ymax"], self.space_limits["ymin"]
        if self.space_limits["zmin"] > self.space_limits["zmax"]:
            print(RED + "WARNING: zmin is greater than zmax, swapping them for display." + RESET)
            self.space_limits["zmin"], self.space_limits["zmax"] = self.space_limits["zmax"], self.space_limits["zmin"]

    def table_printer(self, model: Model, system) -> None:
        """
        Prints the model as a table.

        Args:
            model (Model): The clingo model to be printed.
            system (MetaSystem): The metasp system.
        """
        # In the temporal encoding, shown atoms have the shape true(F,K).
        # We first collect object declarations per state, e.g.
        # {0: {'point': {'a', 'b'}}, 1: {'point': {'a', 'b'}}}.
        # Static models use state=None and keep the old behavior.
        sort2objs_by_state = defaultdict(lambda: defaultdict(set))   # example: {0: {'point': {'a', 'b'}}, ...}
        # Human-readable atoms printed next to "State K:". A set deduplicates
        # formulas that appear both in shown=True and atoms=True.
        shown_by_state = defaultdict(set)
        has_temporal_atoms = False
        for sym in model.symbols(shown=True):  # NOTE you need to include them in the #show then
            #print("sym: ", sym)  # examples: true(point(a)), true(__left(a,b)), true(p), ... everything that starts with 'true'
            if sym.name in {"invalid_relation_arg", "invalid_action_arg"}:
                kind = "relation" if sym.name == "invalid_relation_arg" else "action"
                print(RED + "ERROR: Invalid " + kind + " >> " + str(sym.arguments[0])[2:] + " <<. No signature for arguments of these sorts. Solving stopped." + RESET)
                return

        # shown=True is not always enough for derived spatial atoms after the
        # meta-time transformation. Looking at true atoms as well lets the table
        # header include relations such as on(a,b) at each state.
        for sym in list(model.symbols(shown=True)) + list(model.symbols(atoms=True)):
            if sym.name == "true" and sym.arguments:  # = something inside the "true" predicate
                formula = sym.arguments[0]
                state = None
                if len(sym.arguments) == 2 and sym.arguments[1].type == SymbolType.Number:
                    state = sym.arguments[1].number
                    has_temporal_atoms = True

                pred_name = formula.name
                #print("pred_name: ", pred_name) # out: point, point, __left, __df, ...
                if pred_name in GEOMETRIC_SORT_PREDICATES: # geometric sort declaration case (e.g. point(a))
                    if len(formula.arguments) > 1:
                        print(RED + "ERROR: Invalid declaration >> " + str(formula) + " <<. You probably used , instead of ; for declaring multiple objects. Solving stopped." + RESET)
                        return
                    else:
                        # Use the full symbol as object key, not only .name.
                        # For compound object identifiers like bank(near) and
                        # bank(far), .name would be "bank" for both and the
                        # display table/plot would collapse them into one object.
                        sort2objs_by_state[state][pred_name].add(str(formula.arguments[0]))
                        shown_formula = self.format_shown_formula(formula)
                        if shown_formula is not None:
                            shown_by_state[state].add(shown_formula)
                elif formula.name.startswith("__"):   # expression starting with '&' in the input program
                    shown_formula = self.format_shown_formula(formula)
                    if shown_formula is not None:
                        shown_by_state[state].add(shown_formula)
            #elif sym.arguments[0].name not in GEOMETRIC_SORTS:
                else:  # other symbols, like p, q, r, p(123). sym.arguments[0] prints p, as p(123), regardless of arity.
                    shown_formula = self.format_shown_formula(formula)
                    if shown_formula is not None:
                        shown_by_state[state].add(shown_formula)

        if has_temporal_atoms:
            # Prefer the configured horizon if available, so empty-but-existing
            # states still print and can be animated. Then add any state numbers
            # discovered in the model as a fallback.
            try:
                states = set(range(int(system.constants["n"]) + 1))
            except (KeyError, TypeError, ValueError):
                states = set()
            states.update(state for state in sort2objs_by_state if state is not None)
            states.update(state for state in shown_by_state if state is not None)
        else:
            states = {None}

        val4diag_by_state = {}
        pairs_obj_sort_by_state = {}
        for state in states:
            sort2objs = sort2objs_by_state.get(state, {})
            # val4diag is the display-oriented data structure:
            # {'point': {'a': {'x': 0, 'y': 1}}, 'rect': {...}}.
            # For traces we build one val4diag per state.
            val4diag_by_state[state] = {geometric_sort_predicate: {} for geometric_sort_predicate in sort2objs.keys()}
            pairs_obj_sort_by_state[state] = dict()
            for sort, objs in sort2objs.items():
                val4diag_by_state[state][sort] = {obj_name: {} for obj_name in objs}  # example: {'point': {'a': {}, 'b': {}}, ...
                pairs_obj_sort_by_state[state].update({obj_name: sort for obj_name in objs})  # example: {'a': 'point', 'b': 'rect', ...
        """
        Builds a dictionary of geometric objects and their value assignments.
        Ex: {'point': {'p1': {'x': 0, 'y': 0}, 'p2': {'x': 1, 'y': 1}}, 'rect': ...}
        """
        for sym in model.symbols(theory=True):
            #print(sym)  # examples: __csp(y(c),0), __csp(x(c),1), ...
            param_as_clingo_function = sym.arguments[0]
            value = sym.arguments[1].number

            if not param_as_clingo_function.arguments:
                continue

            param = param_as_clingo_function.name
            # Same convention as object declarations above: keep compound terms
            # intact, e.g. left_side(bank(near),K) belongs to object "bank(near)".
            obj_name = str(param_as_clingo_function.arguments[0])
            state = None
            # Temporal geometry terms are represented as x(a,0), bottom(r,2),
            # etc. The second argument is the state used to route the value into
            # the correct val4diag. Atemporal old-style terms keep state=None.
            if len(param_as_clingo_function.arguments) > 1 and param_as_clingo_function.arguments[1].type == SymbolType.Number:
                state = param_as_clingo_function.arguments[1].number

            if state not in pairs_obj_sort_by_state or obj_name not in pairs_obj_sort_by_state[state]:
                continue

            sort = pairs_obj_sort_by_state[state][obj_name]
            if not model.contains(Function("__def", [param_as_clingo_function])):  # if the parameter is not defined, register None
                val4diag_by_state[state][sort][obj_name][param] = None
            else:
                val4diag_by_state[state][sort][obj_name][param] = value

        if self.use_mpl_display:
            if has_temporal_atoms and len(self.trace4diags) < self.max_figures:
                # Store the whole trace as one dynamic model. display_at_exit
                # later animates each trace in a grid cell.
                self.trace4diags.append({
                    state: val4diag_by_state[state]
                    for state in sorted(states)
                })
            elif not has_temporal_atoms and len(self.val4diags) < self.max_figures:
                # Static models still use the original list of independent
                # diagrams, preserving the old mpl_printer behavior.
                self.val4diags.append(val4diag_by_state[None])

        if has_temporal_atoms:
            for state in sorted(states):
                sys.stdout.write("State {}:".format(state))
                for shown in sorted(shown_by_state.get(state, [])):
                    sys.stdout.write(" {}".format(shown))
                sys.stdout.write("\n")
                print_val4diag_table(val4diag_by_state.get(state, {}))
        else:
            for shown in shown_by_state.get(None, []):
                sys.stdout.write("{} ".format(shown))
            sys.stdout.write("\n")
            print_val4diag_table(val4diag_by_state[None])

    # called each time a new model is found
    def mpl_printer(self, model: Model, system) -> None:
        """
        Relies on table_printer to build the val4diags list.
        A flag is used to track whether to display the solutions with matplotlib.
        """
        # The table printer is the single place that translates solver symbols
        # into val4diag/trace4diag. mpl_printer only turns on collection and
        # configures display constants before delegating.
        self.use_mpl_display = True
        self.display_time = self.get_display_time(system)
        self.set_space_limits_from_constants(system)
        self.table_printer(model, system)

    def has_undefined_value(self):
        static_has_undefined = any(
            value is None
            for val4diag in self.val4diags
            for objects_by_name in val4diag.values()
            for params in objects_by_name.values()
            for value in params.values()
        )
        traces_have_undefined = any(
            value is None
            for trace in self.trace4diags
            for val4diag in trace.values()
            for objects_by_name in val4diag.values()
            for params in objects_by_name.values()
            for value in params.values()
        )
        return static_has_undefined or traces_have_undefined

    def has_missing_required_params(self):
        geometric_displayer = GeometricDisplayer(
            self.space_limits["xmin"],
            self.space_limits["xmax"],
            self.space_limits["ymin"],
            self.space_limits["ymax"],
            self.space_limits["zmin"],
            self.space_limits["zmax"],
            display_time=self.display_time,
        )
        static_missing = not geometric_displayer.has_required_params(self.val4diags)
        traces_missing = any(
            not geometric_displayer.has_required_params(trace.values())
            for trace in self.trace4diags
        )
        return static_missing or traces_missing

    def display_at_exit(self):
        """
        Displays the solutions with matplotlib if the mpl printer was selected
        and the number of solutions is less than or equal to max_figures.
        Example val4diags : [{'point': {'p1': {'x': 0, 'y': 0}, 'p2': {'x': 1, 'y': 1}}, 'rect':  ...],
        """
        # The solver calls the printer once per model, but matplotlib display
        # should happen after solving, when all static models/traces have been
        # collected. atexit gives us that final hook.
        if self.use_mpl_display and self.has_undefined_value():
            print(YELLOW + "WARNING:"+ GREY + " You asked for the matplotlib printer but some parameters are unconstrained and remain undefined, diagrams cannot be displayed. \n"
                        "Add 'df.' axiom to the input file to define all the parameters." + RESET)
            return

        if self.use_mpl_display and self.has_missing_required_params():
            print(YELLOW + "WARNING:"+ GREY + " You asked for the matplotlib printer but some objects miss coordinates needed for diagrams. \n"
                        "For points, make sure both x and y are defined at every displayed state." + RESET)
            return

        if self.use_mpl_display and (self.val4diags or self.trace4diags):
            geometric_displayer = GeometricDisplayer(
                    self.space_limits["xmin"],
                    self.space_limits["xmax"],
                    self.space_limits["ymin"],
                    self.space_limits["ymax"],
                    self.space_limits["zmin"],
                    self.space_limits["zmax"],
                    display_time=self.display_time,
                )

        if self.use_mpl_display and 0 < len(self.val4diags) <= self.max_figures:
            geometric_displayer.display(self.val4diags)

        if self.use_mpl_display and 0 < len(self.trace4diags) <= self.max_figures:
            # Temporal models are animated together in one stable grid window:
            # one subplot per trace, with each subplot updated across states.
            geometric_displayer.display_traces(self.trace4diags)


printer_manager = PrinterManager()
atexit.register(printer_manager.display_at_exit)


def table_printer(model: Model, system) -> None:
    printer_manager.table_printer(model, system)


def mpl_printer(model: Model, system) -> None:
    printer_manager.mpl_printer(model, system)