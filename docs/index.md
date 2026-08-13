# flingdia encodings

Pilot documentation generated with [clindocs](https://potassco.org/clindocs/) from the
comments of the encodings themselves. Three files are covered so far: the temporal
semantics, the spatial axioms and the point-point relations. They are documented as a
single set, so the glossary, the predicate table and the dependency graph below span all
three.

!!! note "Theory atoms"

    The spatial and temporal vocabulary of flingdia consists of theory atoms
    (`&left_pp/2`, `&until/2`, `&move/1`, ...). The clingo grammar used by clindocs only
    tracks ordinary predicates, so theory atoms are documented as pseudo-predicates
    written without the leading `&`. They therefore appear below without definitions or
    references, while the meta-level predicates (`true/2`, `formula/2`, `time/1`, ...)
    are tracked normally.

::: schemas/rels/point_point.lp
    handler: asp
    options:
        extra_includes:
            - semantics.lp
            - axioms.lp
        glossary: true
        predicate_table: true
        dependency_graph: true
        encodings:
            source: true
        start_level: 1
