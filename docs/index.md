Flingdia is a declarative system for spatial reasoning. Its semantics are described in:

> Olivier, F., Diéguez, M., and Schultz, C. (2026). *Declarative Spatial
> Reasoning in Temporal Here-and-There with Constraints*. In ASPOCP 2026:
> 19th Workshop on Answer Set Programming and Other Computing Paradigms,
> FLoC 2026, Lisbon, Portugal.

This documentation gives a brief overview of the language and its encodings.

## Geometric sorts

Flingdia programs use the standard clingo language extended with spatial atoms.
Before using a spatial atom, declare each geometric object with one of the
ordinary ASP predicates `point/1`, `rect/1`, or `line/1`.

In Flingdia, a *sort* is a geometric category, not a clingo type declaration.
It determines the parameters available to an object and which overloaded
relations and actions may accept it. Declaring a sort does not assign parameter
values or assert a spatial relation.

| Object | Parameters |
| --- | --- |
| Point — `point(P)` | `x`, `y` |
| Rectangle — `rect(R)` | `left_side`, `bottom`, `width`, `height` |
| Line — `line(L)` | `xstart`, `ystart`, `xend`, `yend` |

See the [axioms page](axioms.md) for validity conditions and spatial bounds.

## Spatial relations

Spatial relations are theory atoms of the form `&relation(arguments)`. For
example, the following program declares two points and places `a` to the left
of `b`:

```clingo
point(a).
point(b).
&left(a,b).
```

Relation names are overloaded: the types of their arguments determine their
meaning. Thus, `&left(a,b)` can relate two points, a point and a rectangle, or
two rectangles. The corresponding relation pages in the navigation describe
the supported object combinations precisely.

Flingdia uses the usual Cartesian orientation:

```text
                         y
                         ↑
                above   │
    left  ←──────────────┼──────────────→  right   x
                below   │
                         ↓
```

Consequently, smaller `x` values lie farther left and smaller `y` values lie
farther below. A rectangle is anchored by its `left_side` and `bottom`;
`right_side` and `top` are derived from its `width` and `height`.

## Running Flingdia

Run Flingdia from the `metasp/examples/flingdia` directory. For example:

```bash
metasp solve flingo --meta-config config.yaml \
    --warn=no-atom-undefined \
    instances/TEMP/blocks_world.lp 1 \
    -c n=5 --project=show
```

The input file is followed by the requested number of models (`0` means all
models). The option `-c n=5` sets the temporal horizon, while `--project=show`
projects solutions onto the displayed atoms. Each example file under
`instances/` begins with a block comment containing its complete launch
command, which can be copied and run from this directory.

!!! note "Default axioms: definedness and inertia"

    By default, Flingdia assigns values to every parameter of every declared
    object in the initial state. Parameter values then persist through time by
    inertia unless a rule or action supports a change.

    Add the following facts to an input program to disable either default:

    ```clingo
    &partial.       % Allow parameters to remain undefined.
    &not_inertia.   % Disable persistence of parameter values.
    ```

    The directives are independent, so an input program may use either one or
    both. See the [axioms page](axioms.md) for the complete encoding.


This documentation is generated with [Clindocs](https://potassco.org/clindocs/)
directly from the comments in the Flingdia encodings.
