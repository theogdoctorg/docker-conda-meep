# docker-conda-meep
Docker image to host an Anaconda Python environment with (parallel) Meep &amp; supporting files

## Python packages

## Usage
You can run either normal (single-threaded) or parallel MEEP from either a Jupyter notebook environment or the Spyder IDE.

### Jupyter
Run the following command: 
'sudo docker run -i -t -p 8888:8888 --mount type=bind,src=<notebook directory>,dst=/home/host \
theogdoctorg/conda-meep /bin/bash -c "normal_meep.sh"
'
for single-threaded operation.

## Building a new Docker image
Using git, clone the repo to a local folder
in that folder,  run

'
sudo docker build -t theogdoctorg/conda-meep .
'
