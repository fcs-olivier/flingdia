"""Generate the three sort-parameter coordinate systems for the home page."""

from pathlib import Path

output_path = Path(__file__).with_name("sorts") / "parameters.svg"
output_path.parent.mkdir(parents=True, exist_ok=True)

panel_width, height = 330, 350
grid_left, grid_bottom, grid_step = 36, 310, 40
n_ticks = 8
param_fill = "#1d4ed8"
shape_fill = "#111827"

svg = [
    f'<svg xmlns="http://www.w3.org/2000/svg" '
    f'width="{panel_width * 3}" height="{height}" '
    f'viewBox="0 0 {panel_width * 3} {height}">',
    "<defs>",
    '<marker id="dim" markerWidth="7" markerHeight="7" refX="6" refY="3.5" '
    'orient="auto">',
    f'<path d="M0,0 L7,3.5 L0,7" fill="none" stroke="{param_fill}" '
    'stroke-width="1.2"/>',
    "</marker>",
    '<marker id="dim-start" markerWidth="7" markerHeight="7" refX="1" refY="3.5" '
    'orient="auto">',
    f'<path d="M7,0 L0,3.5 L7,7" fill="none" stroke="{param_fill}" '
    'stroke-width="1.2"/>',
    "</marker>",
    "</defs>",
    "<style>",
    "text{font:13px sans-serif}",
    ".grid{stroke:#bbb;stroke-width:1}",
    ".axis{stroke:#333;stroke-width:2}",
    ".shape{fill:none;stroke-width:3}",
    ".guide{stroke:#93c5fd;stroke-width:1.4;stroke-dasharray:5 4}",
    f".param{{font:12px ui-monospace,SFMono-Regular,Menlo,monospace;"
    f"fill:{param_fill};font-weight:700}}",
    ".title{font-weight:700}",
    "</style>",
]


def xy(left, x, y):
    return left + x * grid_step, grid_bottom - y * grid_step


def grid(left, title):
    for value in range(n_ticks):
        x, y = left + value * grid_step, grid_bottom - value * grid_step
        svg.extend([
            f'<line class="grid" x1="{x}" y1="30" x2="{x}" y2="{grid_bottom}"/>',
            f'<line class="grid" x1="{left}" y1="{y}" '
            f'x2="{left + (n_ticks - 1) * grid_step}" y2="{y}"/>',
            f'<text x="{x}" y="{grid_bottom + 20}" text-anchor="middle">{value}</text>',
            f'<text x="{left - 10}" y="{y + 4}" text-anchor="end">{value}</text>',
        ])
    svg.extend([
        f'<line class="axis" x1="{left}" y1="{grid_bottom}" '
        f'x2="{left + (n_ticks - 1) * grid_step + 10}" y2="{grid_bottom}"/>',
        f'<line class="axis" x1="{left}" y1="{grid_bottom}" '
        f'x2="{left}" y2="20"/>',
        f'<text x="{left + (n_ticks - 1) * grid_step + 18}" '
        f'y="{grid_bottom + 4}">x</text>',
        f'<text x="{left - 4}" y="15">y</text>',
        f'<text class="title" x="{left + 140}" y="18" text-anchor="middle">{title}</text>',
    ])


def guide(x1, y1, x2, y2):
    svg.append(
        f'<line class="guide" x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}"/>'
    )


def param(text, x, y, anchor="middle"):
    svg.append(
        f'<text class="param" x="{x}" y="{y}" text-anchor="{anchor}">{text}</text>'
    )


def dim_h(x1, x2, y, label, label_dy=-8):
    svg.append(
        f'<line x1="{x1}" y1="{y}" x2="{x2}" y2="{y}" stroke="{param_fill}" '
        'stroke-width="1.4" marker-start="url(#dim-start)" marker-end="url(#dim)"/>'
    )
    param(label, (x1 + x2) / 2, y + label_dy)


def dim_v(x, y1, y2, label, label_dx=8):
    svg.append(
        f'<line x1="{x}" y1="{y1}" x2="{x}" y2="{y2}" stroke="{param_fill}" '
        'stroke-width="1.4" marker-start="url(#dim-start)" marker-end="url(#dim)"/>'
    )
    param(label, x + label_dx, (y1 + y2) / 2 + 4, anchor="start")


# --- Point: P at (4, 5) ---
left = grid_left
grid(left, "point(P)")
px, py = xy(left, 4, 5)
ox, oy = xy(left, 0, 0)
guide(px, py, px, oy)
guide(px, py, ox, py)
svg.append(f'<circle cx="{px}" cy="{py}" r="5" fill="{shape_fill}"/>')
svg.append(f'<text x="{px + 8}" y="{py - 8}" fill="{shape_fill}">P</text>')
param("x", px, oy - 10)
param("y", ox + 12, py + 4, anchor="start")

# --- Rectangle: left_side=2, bottom=2, width=3, height=3 ---
left = panel_width + grid_left
grid(left, "rect(R)")
x1, y_top = xy(left, 2, 5)
x2, y_bot = xy(left, 5, 2)
ox, oy = xy(left, 0, 0)
svg.append(
    f'<rect class="shape" x="{x1}" y="{y_top}" width="{x2 - x1}" '
    f'height="{y_bot - y_top}" stroke="{shape_fill}"/>'
)
svg.append(
    f'<text x="{(x1 + x2) / 2}" y="{(y_top + y_bot) / 2 + 4}" '
    f'text-anchor="middle" fill="{shape_fill}">R</text>'
)
guide(x1, y_bot, x1, oy)
guide(x1, y_bot, ox, y_bot)
dim_h(x1, x2, y_bot + 18, "width", label_dy=14)
dim_v(x2 + 16, y_bot, y_top, "height")
param("left_side", x1, oy - 10)
param("bottom", ox + 12, y_bot + 4, anchor="start")

# --- Line: (1, 2) → (6, 5) ---
left = 2 * panel_width + grid_left
grid(left, "line(L)")
x_s, y_s = xy(left, 2, 2)
x_e, y_e = xy(left, 6, 5)
ox, oy = xy(left, 0, 0)
svg.extend([
    f'<line class="shape" x1="{x_s}" y1="{y_s}" x2="{x_e}" y2="{y_e}" '
    f'stroke="{shape_fill}"/>',
    f'<circle cx="{x_s}" cy="{y_s}" r="4" fill="{shape_fill}"/>',
    f'<circle cx="{x_e}" cy="{y_e}" r="4" fill="{shape_fill}"/>',
    f'<text x="{(x_s + x_e) / 2 + 10}" y="{(y_s + y_e) / 2 - 6}" '
    f'fill="{shape_fill}">L</text>',
])
guide(x_s, y_s, x_s, oy)
guide(x_s, y_s, ox, y_s)
guide(x_e, y_e, x_e, oy)
guide(x_e, y_e, ox, y_e)
param("xstart", x_s, oy - 10)
param("xend", x_e, oy - 10)
param("ystart", ox + 12, y_s + 4, anchor="start")
param("yend", ox + 12, y_e + 4, anchor="start")

svg.append("</svg>")
output_path.write_text("\n".join(svg), encoding="utf-8")
print(output_path)
