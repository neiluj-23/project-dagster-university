#!/usr/bin/env bash
# Launch the Dagster dev server with a persistent, project-local DAGSTER_HOME.

# TODO 1: strict mode
set -euo pipefail

# TODO 2: resolve project_dir from this script's location, not from $PWD
project_dir=$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")

# TODO 3: move into project_dir
cd "$project_dir"

# TODO 4: build DAGSTER_HOME as a Windows-readable path, create it, export it
dagster_home="$project_dir/.dagster_home"
mkdir -p "$dagster_home"
export DAGSTER_HOME="$dagster_home"

# create dagster.yaml if it doesn't exist
if [ ! -f "$DAGSTER_HOME/dagster.yaml" ]; then
    echo "Creating default dagster.yaml in $DAGSTER_HOME"
    cat > "$DAGSTER_HOME/dagster.yaml" <<EOL
# This is a default dagster.yaml file created by dev.sh.
# You can customize it as needed for your project.
EOL
fi  

# TODO 5: hand over to the dev server, forwarding any arguments
unset VIRTUAL_ENV
exec uv run dg dev "$@"