#!/bin/bash

eval "$(conda shell.bash hook)"

# Set openapi key if it exists
if [[ $OPENAI_APIKEY_INPUT != "none" ]] 
then
    export OPENAI_APIKEY=$(echo $OPENAI_APIKEY_INPUT)
fi
# Start server.py and jupyterlab
cd /PI2
conda activate pi
jupyter lab --allow-root --ip='*' --no-browser --NotebookApp.token='' --NotebookApp.password='' &
python /PI2/pi-server/server.py &