# flingdia

[Documentation](https://github.com/fcs-olivier/flingdia)

Flingdia is a declarative language for spatio-temporal reasoning, built on
[metasp](https://github.com/potassco/metasp) / flingo.

## Requirements

```bash
pip install metasp matplotlib
```

- **metasp** — solver frontend (pulls in flingo)
- **matplotlib** — diagram printer (`mpl_printer` in `config.yaml`)

## Usage

From this directory:

```bash
metasp solve flingo --meta-config config.yaml --warn=no-atom-undefined \
    instances/TEMP/blocks_world.lp 0 -c n=5 --project=show
```

`config.yaml` lists the syntax, semantics, schemas, and printer. Instances live
under `instances/`; the first comment block of each file shows its intended
command. See the documentation for printers, the temporal horizon, and the rest
of the language.
