<div align="center">

[![License](https://img.shields.io/badge/license-MIT-green)](https://github.com/kscalelabs/urdf2mjcf/blob/main/LICENSE)
[![Version](https://img.shields.io/pypi/v/urdf2mjcf)](https://pypi.org/project/urdf2mjcf/)
[![Discord](https://img.shields.io/discord/1224056091017478166)](https://discord.gg/kscale)
[![Wiki](https://img.shields.io/badge/wiki-humanoids-black)](https://humanoids.wiki)
<br />
[![python](https://img.shields.io/badge/-Python_3.11-blue?logo=python&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![black](https://img.shields.io/badge/Code%20Style-Black-black.svg?labelColor=gray)](https://black.readthedocs.io/en/stable/)
[![ruff](https://img.shields.io/badge/Linter-Ruff-red.svg?labelColor=gray)](https://github.com/charliermarsh/ruff)
<br />
[![Python Checks](https://github.com/kscalelabs/urdf2mjcf/actions/workflows/test.yml/badge.svg)](https://github.com/kscalelabs/urdf2mjcf/actions/workflows/test.yml)
[![Publish Python Package](https://github.com/kscalelabs/urdf2mjcf/actions/workflows/publish.yml/badge.svg)](https://github.com/kscalelabs/urdf2mjcf/actions/workflows/publish.yml)

</div>

## urdf2mjcf

Convert URDF robot descriptions to MJCF XML for use with MuJoCo.

- **Docs**: Full documentation is available at [`https://docs.kscale.dev/docs/urdf2mjcf`](https://docs.kscale.dev/docs/urdf2mjcf).
- **Source**: [`https://github.com/kscalelabs/urdf2mjcf`](https://github.com/kscalelabs/urdf2mjcf).

## Installation

Install from PyPI (Python 3.11+):

```bash
pip install urdf2mjcf
```

## Command-line usage

After installation, the `urdf2mjcf` CLI is available:

```bash
urdf2mjcf path/to/robot.urdf --output path/to/robot.xml
```

Common options:

- `--copy-meshes`: **Copy** mesh files into the output directory.
- `--metadata`: **Inline JSON** metadata describing joints, actuators, and sensors.
- `--metadata-file`: **Path** to a JSON file containing the same metadata.
- `--log-level`: **Logging level** (e.g., `20` for `INFO`, `10` for `DEBUG`).

For more flags and examples, run:

```bash
urdf2mjcf --help
```

You can also batch-convert URDFs with the provided helper script:

```bash
# Convert all *.urdf files under MODELS_DIR to *.xml in-place.
# Optionally pass a metadata.json file with global conversion settings.
./batch_convert_urdf.sh MODELS_DIR [PATH_TO_METADATA_JSON]

# Example
./batch_convert_urdf.sh ./models ./metadata.json
```

## Python API

You can call the converter directly from Python:

```python
from pathlib import Path

from urdf2mjcf import run

urdf_path = Path("path/to/robot.urdf")
mjcf_path = Path("path/to/robot.xml")

run(
    urdf_path=urdf_path,
    mjcf_path=mjcf_path,
    copy_meshes=True,
)
```

For advanced usage (custom joint and actuator metadata, sensors, floor/contact options, etc.), see the API docs and examples in the main documentation.

## Development environment

To work on `urdf2mjcf` locally with an isolated environment (Python 3.11+), you can use `uv`:

```bash
# Install uv (see https://docs.astral.sh/uv/ for other options)
curl -LsSf https://astral.sh/uv/install.sh | sh
# or:
# pip install uv

# Create and activate a virtual environment
uv venv .venv
source .venv/bin/activate

# Install the package with development dependencies
uv pip install -e ".[dev]"
```

You can then run tests with:

```bash
pytest
```
