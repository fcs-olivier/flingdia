"""Shortest one-vehicle-per-step plan for the rush_hour instance, by BFS.

Solver-independent reference point: it fixes which horizons n can possibly be
SAT, so a long run can be attributed to search behaviour rather than to a wrong
horizon. Mirrors rush_hour_one_mover.lp on a 6x6 board: a step moves exactly one
vehicle by one cell along its own axis, vehicles stay on the board and never
overlap. Goal: right_side(red) = 6, which makes &touches(red,exit) hold for
exit = (6,4) via the top-edge contact case.

Run: python3 min_moves_bfs.py
"""

from collections import deque

# name, left_side, bottom, width, height
CARS = [
    ("red", 0, 3, 2, 1),
    ("beige", 0, 0, 1, 2),
    ("pink", 1, 0, 2, 1),
    ("yellow", 2, 1, 1, 3),
    ("orange", 3, 1, 2, 1),
    ("plum", 3, 2, 1, 2),
    ("purple", 5, 1, 1, 3),
    ("blue", 2, 4, 3, 1),
]
WIDTH = HEIGHT = 6
RED = 0
RED_GOAL_LEFT_SIDE = 4

NAMES = [c[0] for c in CARS]
SHAPES = [(c[3], c[4]) for c in CARS]
HORIZONTAL = [w > h for w, h in SHAPES]
START = tuple((c[1], c[2]) for c in CARS)


def cells(i, pos):
    x, y = pos
    w, h = SHAPES[i]
    return [(x + dx, y + dy) for dx in range(w) for dy in range(h)]


def valid(state):
    occupied = set()
    for i, pos in enumerate(state):
        for cell in cells(i, pos):
            if not (0 <= cell[0] < WIDTH and 0 <= cell[1] < HEIGHT):
                return False
            if cell in occupied:
                return False
            occupied.add(cell)
    return True


def successors(state):
    for i in range(len(CARS)):
        deltas = [(1, 0), (-1, 0)] if HORIZONTAL[i] else [(0, 1), (0, -1)]
        for dx, dy in deltas:
            candidate = list(state)
            candidate[i] = (state[i][0] + dx, state[i][1] + dy)
            candidate = tuple(candidate)
            if valid(candidate):
                yield candidate, (NAMES[i], dx, dy)


def main():
    assert valid(START), "initial state is already invalid"
    origin = {START: None}
    queue = deque([START])
    goal = None
    while queue:
        state = queue.popleft()
        if state[RED][0] == RED_GOAL_LEFT_SIDE:
            goal = state
            break
        for nxt, action in successors(state):
            if nxt not in origin:
                origin[nxt] = (state, action)
                queue.append(nxt)

    if goal is None:
        print(f"unsolvable ({len(origin)} states explored)")
        return

    plan = []
    state = goal
    while origin[state] is not None:
        previous, action = origin[state]
        plan.append(action)
        state = previous
    plan.reverse()

    print(f"shortest plan: {len(plan)} moves ({len(origin)} states explored)")
    for step, (name, dx, dy) in enumerate(plan, 1):
        direction = {(1, 0): "right", (-1, 0): "left", (0, 1): "up", (0, -1): "down"}[(dx, dy)]
        print(f"  {step:2d}. {name} {direction}")
    print(f"=> UNSAT for n <= {len(plan) - 1}, SAT for n >= {len(plan)}")


if __name__ == "__main__":
    main()
