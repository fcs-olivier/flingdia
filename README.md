# flingdia

Spatio-temporal reasoning encodings for [metasp](https://github.com/potassco/metasp) / flingo.

## Requirements

To run the encodings:

```bash
pip install metasp matplotlib
```

- **metasp** — solver frontend (pulls in flingo)
- **matplotlib** — diagram printer (`mpl_printer` in `config.yaml`)

## Usage

From this directory:

```bash
metasp solve flingo --meta-config config.yaml --warn=no-atom-undefined \
    instances/ST/blocks_world.lp 1 -c n=5 --project=show
```

`config.yaml` lists the syntax, semantics, schemas, and printer. Switch `printer` to `table_printer` if you do not want diagrams. Instances live under `instances/`; the first comment block of each file shows its intended command.

## Documentation (optional)

Not needed to use the system. Comments in the `.lp` files can be rendered locally with [clindocs](https://potassco.org/clindocs/) (which includes MkDocs):

```bash
pip install clindocs
mkdocs serve -a 127.0.0.1:8123
```

Then open http://127.0.0.1:8123/. Stop with `Ctrl+C`.
