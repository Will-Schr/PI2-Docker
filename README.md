# PI2 Unoffical Docker Image

An unofficial docker image project for the [pi2 end-to-end interactive visualization interface generation from queries](https://github.com/learnedinterfaces/PI2) project

Still a work in progress

## Install from dockerfile

Download dockerfile, and open a terminal in the directory you downloaded the docker image into.
Then run
```
docker build -t pi2_image .
docker run -i -t --name pi2_cont --env OPENAI_APIKEY=YOURAPIKEYHERE -p 8000:8000 -p 8888:8888 pi2
```
