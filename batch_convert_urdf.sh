#!/usr/bin/env bash
set -euo pipefail

# Batch-convert all URDF files under a models directory to MJCF XML.
# You can optionally provide a metadata.json file; if you don't, a
# small default metadata object is passed inline via --metadata.
#
# Usage:
#   ./batch_convert_urdf.sh MODELS_DIR [PATH_TO_METADATA_JSON]

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 MODELS_DIR [PATH_TO_METADATA_JSON]" >&2
  exit 1
fi

MODELS_DIR="$1"
METADATA_PATH="${2:-}"

if [[ ! -d "${MODELS_DIR}" ]]; then
  echo "Models directory not found: ${MODELS_DIR}" >&2
  exit 1
fi

# Default inline metadata if no file is provided. This disables the floating base
# and freejoint so objects behave like static props by default.
DEFAULT_METADATA_JSON='{"floating_base": true, "freejoint": true}'

if [[ -n "${METADATA_PATH}" ]]; then
  if [[ ! -f "${METADATA_PATH}" ]]; then
    echo "Metadata file not found: ${METADATA_PATH}" >&2
    exit 1
  fi
  echo "Using metadata file: ${METADATA_PATH}"
else
  echo "No metadata file provided; using inline metadata: ${DEFAULT_METADATA_JSON}"
fi
echo "Searching for URDF files under: ${MODELS_DIR}"

find "${MODELS_DIR}" -type f -name "*.urdf" | while read -r urdf; do
  dir="$(dirname "${urdf}")"
  base="$(basename "${urdf}" .urdf)"
  out_xml="${dir}/${base}.xml"

  echo "Converting: ${urdf}"
  echo "  -> ${out_xml}"

  if [[ -n "${METADATA_PATH}" ]]; then
    # Use the metadata JSON file for global conversion settings.
    if ! urdf2mjcf "${urdf}" --metadata-file "${METADATA_PATH}" --output "${out_xml}"; then
      echo "  !! Conversion failed for ${urdf} (see error above), skipping." >&2
      continue
    fi
  else
    # Fall back to inline default metadata.
    if ! urdf2mjcf "${urdf}" --metadata "${DEFAULT_METADATA_JSON}" --output "${out_xml}"; then
      echo "  !! Conversion failed for ${urdf} (see error above), skipping." >&2
      continue
    fi
  fi
done

echo "Done converting URDFs."


