########################################################################################
# Example environment setup script for Caravel Management SoC env vars with LiteX and Microwatt #
########################################################################################

#!/bin/bash

# Define base directory as the current working directory when the script is executed
BASE_DIR=$(pwd)

conda activate microwatt
# Set PDK_ROOT (change to your desired path if needed, e.g., ~/pdk)
export PDK_ROOT="$BASE_DIR/caravel_mgmt_soc_litex/dependencies/pdks"  # Adjust if you have a different PDK install path

# Set CARAVEL_ROOT to the management SoC install directory
export CARAVEL_ROOT="$BASE_DIR/caravel_mgmt_soc_litex/caravel"

# Set OPENLANE_ROOT (if not using Docker; adjust if you have a custom install)
export OPENLANE_ROOT="$BASE_DIR/openlane"  # Change if installed elsewhere

# Set USER_ID (replace with your actual Efabless user ID)
export USER_ID=00000010  # Example; update with your real ID

# Set PROJECT (replace with your project name)
export PROJECT=mgmt_soc  # Example; update as needed
#export MGMT_AREA_ROOT="$BASE_DIR/caravel_mgmt_soc_litex/mgmt_core_wrapper"
export UPRJ_ROOT="$BASE_DIR/caravel_mgmt_soc_litex"
#Env vars for verification
export GCC_PATH="/usr/bin"
export GCC_PREFIX="powerpc64le-linux-gnu"
# Optional: For LiteX/Microwatt environment (if using Conda)
# conda activate microwatt  # Uncomment and adjust if using Conda


# Optional: Additional paths if needed (e.g., for Python tools)
# export PYTHONPATH=$PYTHONPATH:"$BASE_DIR/litex"

echo "Environment variables set for Caravel Management SoC."
echo "PDK_ROOT: $PDK_ROOT"
echo "CARAVEL_ROOT: $CARAVEL_ROOT"
echo "OPENLANE_ROOT: $OPENLANE_ROOT"
echo "USER_ID: $USER_ID"
echo "PROJECT: $PROJECT"
echo "GCC_PATH: $GCC_PATH"
echo "GCC_PREFIX: $GCC_PREFIX"

# Source this script in your shell: source this_script.sh