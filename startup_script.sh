#!/bin/bash

# Start conda pi environment
conda run -n pi

# Set openapi key if it exists
if [$OPENAI_APIKEY_INPUT != "none"]; then
    export OPENAI_APIKEY=$OPENAI_APIKEY_INPUT

# Start server.py
cd /PI2/pi-server
nohup python bgservice.py &