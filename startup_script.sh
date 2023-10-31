#!/bin/bash

eval "$(conda shell.bash hook)"
# Start conda pi environment
conda run -n pi

# Set openapi key if it exists
if [ $OPENAI_APIKEY_INPUT != "none" ]; then
    export OPENAI_APIKEY=$OPENAI_APIKEY_INPUT
fi
# Start server.py and jupyterlab
cd /PI2
nohup jupyter lab --allow-root --ip='*' --no-browser --NotebookApp.token='' --NotebookApp.password='' &
nohup python /PI2/pi-server/server.py &