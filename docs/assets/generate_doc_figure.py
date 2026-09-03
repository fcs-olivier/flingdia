"""Generate a relation SVG from a compact JSON geometry specification."""

import html
import json
import sys


spec_path, output_path = sys.argv[1:3]
with open(spec_path, encoding="utf-8") as file:
    spec = json.load(file)

panel_width, height = 210, 230
grid_left, grid_bottom, grid_step = 30, 190, 40
svg = [
    f'<svg xmlns="http://www.w3.org/2000/svg" '
    f'width="{panel_width * len(spec["cases"])}" height="{height}" '
    f'viewBox="0 0 {panel_width * len(spec["cases"])} {height}">',
    '<style>text{font:13px sans-serif}.grid{stroke:#bbb;stroke-width:1}'
    '.axis{stroke:#333;stroke-width:2}.shape{fill:none;stroke-width:3}'
    '.endpoint{stroke:none}</style>',
]


def escape(value):
    return html.escape(str(value))


def position(left, coordinates):
    x, y = coordinates
    return left + x * grid_step, grid_bottom - y * grid_step


def entity_type(entity):
    return "point" if isinstance(entity, list) else entity["type"]


def entity_color(name, holds):
    if name != spec.get("subject"):
        return "#111827"
    colors = spec.get("colors", {})
    return colors.get("true", "#16a34a") if holds else colors.get("false", "#dc2626")


for case_index, case in enumerate(spec["cases"]):
    left = case_index * panel_width + grid_left
    for value in range(5):
        x, y = left + value * grid_step, grid_bottom - value * grid_step
        svg.extend([
            f'<line class="grid" x1="{x}" y1="30" x2="{x}" y2="{grid_bottom}"/>',
            f'<line class="grid" x1="{left}" y1="{y}" x2="{left + 160}" y2="{y}"/>',
            f'<text x="{x}" y="{grid_bottom + 20}" text-anchor="middle">{value}</text>',
            f'<text x="{left - 10}" y="{y + 4}" text-anchor="end">{value}</text>',
        ])
    svg.extend([
        f'<line class="axis" x1="{left}" y1="{grid_bottom}" x2="{left + 170}" y2="{grid_bottom}"/>',
        f'<line class="axis" x1="{left}" y1="{grid_bottom}" x2="{left}" y2="20"/>',
        f'<text x="{left + 178}" y="{grid_bottom + 4}">x</text>',
        f'<text x="{left - 4}" y="15">y</text>',
    ])

    holds = case.get("holds", True)
    entities = [
        (name, entity)
        for name, entity in case.items()
        if name not in {"holds", "caption"}
    ]

    # Draw rectangles and lines first so points and all labels remain visible.
    for name, entity in entities:
        kind = entity_type(entity)
        if kind == "point":
            continue
        color = entity_color(name, holds)
        dash = ' stroke-dasharray="6 4"' if entity.get("dashed") else ""
        if kind == "rect":
            x1, y1 = position(left, entity["bounds"][:2])
            x2, y2 = position(left, entity["bounds"][2:])
            svg.append(
                f'<rect class="shape" x="{min(x1, x2)}" y="{min(y1, y2)}" '
                f'width="{abs(x2 - x1)}" height="{abs(y2 - y1)}" '
                f'stroke="{color}"{dash}/>'
            )
            label_at = entity.get(
                "label_at",
                [
                    (entity["bounds"][0] + entity["bounds"][2]) / 2,
                    entity["bounds"][3],
                ],
            )
        elif kind == "line":
            x1, y1 = position(left, entity["start"])
            x2, y2 = position(left, entity["end"])
            svg.extend([
                f'<line class="shape" x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" '
                f'stroke="{color}"{dash}/>',
                f'<circle class="endpoint" cx="{x1}" cy="{y1}" r="4" fill="{color}"/>',
                f'<circle class="endpoint" cx="{x2}" cy="{y2}" r="4" fill="{color}"/>',
            ])
            label_at = entity.get(
                "label_at",
                [
                    (entity["start"][0] + entity["end"][0]) / 2,
                    (entity["start"][1] + entity["end"][1]) / 2,
                ],
            )
        else:
            raise ValueError(f"Unsupported entity type: {kind}")

        label_x, label_y = position(left, label_at)
        svg.append(
            f'<text x="{label_x + 7}" y="{label_y - 7}" '
            f'fill="{color}">{escape(name)}</text>'
        )

    points = [
        (name, entity if isinstance(entity, list) else entity["at"])
        for name, entity in entities
        if entity_type(entity) == "point"
    ]
    coincident = {}
    for name, coordinates in points:
        coincident.setdefault(tuple(coordinates), []).append(name)
    for name, coordinates in points:
        px, py = position(left, coordinates)
        color = entity_color(name, holds)
        siblings = coincident[tuple(coordinates)]
        label_dx, label_dy = 7, -7
        if len(siblings) > 1 and siblings.index(name) == 1:
            label_dx, label_dy = 7, 14
        svg.extend([
            f'<circle cx="{px}" cy="{py}" r="4" fill="{color}"/>',
            f'<text x="{px + label_dx}" y="{py + label_dy}" fill="{color}">{html.escape(name)}</text>',
        ])

svg.append("</svg>")
with open(output_path, "w", encoding="utf-8") as file:
    file.write("\n".join(svg))
