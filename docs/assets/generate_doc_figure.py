"""Generate a relation SVG from a compact JSON specification."""

import html
import json
import sys


spec_path, output_path = sys.argv[1:3]
with open(spec_path, encoding="utf-8") as file:
    spec = json.load(file)

panel_width, height = 210, 230
svg = [
    f'<svg xmlns="http://www.w3.org/2000/svg" '
    f'width="{panel_width * len(spec["cases"])}" height="{height}" '
    f'viewBox="0 0 {panel_width * len(spec["cases"])} {height}">',
    '<style>text{font:13px sans-serif}.grid{stroke:#bbb;stroke-width:1}'
    '.axis{stroke:#333;stroke-width:2}</style>',
]

for case_index, case in enumerate(spec["cases"]):
    left = case_index * panel_width + 30
    bottom = 190
    for value in range(5):
        x, y = left + value * 40, bottom - value * 40
        svg.extend([
            f'<line class="grid" x1="{x}" y1="30" x2="{x}" y2="{bottom}"/>',
            f'<line class="grid" x1="{left}" y1="{y}" x2="{left + 160}" y2="{y}"/>',
            f'<text x="{x}" y="{bottom + 20}" text-anchor="middle">{value}</text>',
            f'<text x="{left - 10}" y="{y + 4}" text-anchor="end">{value}</text>',
        ])
    svg.extend([
        f'<line class="axis" x1="{left}" y1="{bottom}" x2="{left + 170}" y2="{bottom}"/>',
        f'<line class="axis" x1="{left}" y1="{bottom}" x2="{left}" y2="20"/>',
        f'<text x="{left + 178}" y="{bottom + 4}">x</text>',
        f'<text x="{left - 4}" y="15">y</text>',
    ])
    colors = spec.get("colors", {})
    for name, (x, y) in case.items():
        px, py = left + x * 40, bottom - y * 40
        color = html.escape(colors.get(name, "black"))
        svg.extend([
            f'<circle cx="{px}" cy="{py}" r="4" fill="{color}"/>',
            f'<text x="{px + 7}" y="{py - 7}" fill="{color}">{html.escape(name)}</text>',
        ])

svg.append("</svg>")
with open(output_path, "w", encoding="utf-8") as file:
    file.write("\n".join(svg))
