FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]
# Update and set locale
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
# Install npm, build-essential and wget
RUN apt-get update
RUN apt-get -y upgrade
RUN apt install -y build-essential npm wget unzip
# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH
# Create and activate conda env
RUN conda init
RUN conda create --name pi --override-channels --strict-channel-priority -c conda-forge -c nodefaults jupyterlab=3 cookiecutter nodejs jupyter-packaging git -y
# RUN source activate pi
SHELL ["conda", "run", "-n", "pi", "/bin/bash", "-c"]

# Clone PI2 git
RUN wget -qo- https://github.com/learnedinterfaces/PI2/archive/main.zip
RUN unzip main.zip
RUN mv PI2-main PI2
RUN rm main.zip
# Set up pi-client
WORKDIR /PI2/pi-client/
RUN npm install .
RUN npm run build
RUN npm run build-library
# SHELL ["conda", "run", "-n", "pi", "/bin/bash", "-c"]
RUN jlpm link
# Set up pi-jupyter
WORKDIR /PI2/pi-jupyter
RUN npm install .
RUN jlpm link pi-client
RUN jlpm run build
# Set up server
WORKDIR /PI2/pi-server
RUN pip install -r requirements.txt
# Start server
# RUN nohup python /PI2/pi-server/server.py &
EXPOSE 8000