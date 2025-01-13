# docker-conda-meep
Docker image to host an Anaconda Python environment with (parallel) Meep &amp; supporting files

## Python packages

## Usage
You can run either normal (single-threaded) or parallel MEEP from either a Jupyter notebook environment or the Spyder IDE. These are available via selection menu at runtime.

Run the following command: 
'''
sudo docker run -i -t -p 8888:8888 --mount type=bind,src=<directory>,dst=/home/host theogdoctorg/conda-meep 
'''
where <directory> is the path to the folder you would like to have accessible in Meep/Conda. Be aware that a "/notebooks/" folder will be created in this directory to contain the Jupyter notebooks.

## Building a new Docker image
Using git, clone the repo to a local folder
in that folder,  run

'''
sudo docker build -t theogdoctorg/conda-meep .
'''
