#!/bin/bash

eval "$(conda shell.bash hook)"

# Start server.py and jupyterlab
cd /PI2
conda activate pi
jupyter lab --allow-root --ip='*' --no-browser --NotebookApp.token='' --NotebookApp.password='' &
python /PI2/pi-server/server.py &
# Infinite sleep command to stop docker container from quitting at end of script
sleep infinity