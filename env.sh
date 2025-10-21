#!/bin/bash

# Set PDK_ROOT (change to your desired path if needed, e.g., ~/pdk)
export PDK_ROOT=/home/iamme/pdk  # Adjust if you have a different PDK install path

# Set CARAVEL_ROOT to the management SoC install directory
export CARAVEL_ROOT=/home/iamme/asic_tools/caravel_mgmt_soc_litex

# Set OPENLANE_ROOT (if not using Docker; adjust if you have a custom install)
export OPENLANE_ROOT=/home/iamme/asic_tools/openlane  # Change if installed elsewhere

# Set USER_ID (replace with your actual Efabless user ID)
export USER_ID=00000000  # Example; update with your real ID

# Set PROJECT (replace with your project name)
export PROJECT=mgmt_soc  # Example; update as needed

# Optional: For LiteX/Microwatt environment (if using Conda)
# conda activate microwatt  # Uncomment and adjust if using Conda

# Optional: Additional paths if needed (e.g., for Python tools)
# export PYTHONPATH=$PYTHONPATH:/home/iamme/asic_tools/litex

echo "Environment variables set for Caravel Management SoC."
echo "PDK_ROOT: $PDK_ROOT"
echo "CARAVEL_ROOT: $CARAVEL_ROOT"
echo "OPENLANE_ROOT: $OPENLANE_ROOT"
echo "USER_ID: $USER_ID"
echo "PROJECT: $PROJECT"

# Source this script in your shell: source this_script.sh