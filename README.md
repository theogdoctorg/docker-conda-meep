# docker-conda-meep
Docker image to host an Anaconda Python environment with (parallel) Meep &amp; supporting files. Intended to allow for easier installation of Meep in a multiplatform-friendly manner.

## What this image is not
This image does not build Meep from source code! To build Meep from source code in an Ubuntu environment, please use
https://github.com/theogdoctorg/docker-meep-and-mpb

In order to keep the image size small, this image is not intended to be an ML/AI learning environment 

## Installation
### Ubuntu
First install Docker, either via the Ubuntu App center or the (Docker recommended) installation instructions here:

https://docs.docker.com/engine/install/ubuntu/

### Windows (10 or 11)
First enable WSL2 following the documentation here:
https://docs.microsoft.com/en-us/windows/wsl/install-win10

Then install Docker, making sure to use the WSL option, following the instructions here:
https://docs.docker.com/desktop/setup/install/windows-install/

## Usage
You can run either normal (single-threaded) or parallel MEEP from either a Jupyter notebook environment or the Spyder IDE. These are available via selection menu at runtime.

Run the following command: (may need to preceed with "sudo" on Linux)
 
```
docker run -i -t -p 8888:8888 --mount type=bind,src=<directory>,dst=/home/host theogdoctorg/conda-meep 
```

where <directory> is the path to the folder you would like to have accessible in Meep/Conda. Be aware that if either of the Jupyter run options is selected and a "/notebooks/" folder does not exist in this directory, one will be created by the script.

Since Docker runs as a root user, the folders & files created in the mounted directory may need to have permissions modified (chown or chmod in Linux) in order to be later moved/edited/copied by a non-root user.

## Details about Python packages & environments
The image is based on the official Miniconda3 Docker image, and thus should the Python version should stay up-to-date in subsequent rebuilds (currently at 3.11). Two environments are created, "mp" and "pmp", following the official Conda installation instructions here: https://meep.readthedocs.io/en/latest/Installation/

Other packages installed that are common to both environments: matplotlib spyder jupyter numpy scipy vispy
The "pmp" environment also includes ipyparallel for use with Jupyter notebooks.

If you would like to install other images in the environment, you can select option 6 at the prompt which opens a bash shell. Suggested package installation at this prompt: 

```
conda instal -c conda-forge -n <pick mp or pmp> <name of package>
```

Be aware that any changes to the loaded packages will be reset if the container is stopped. If there's a package that would be helpful to include in the base image, please raise as an issue or make the modification in the Dockerfile and add a pull request.

## Building a new Docker image
Using git, clone the repo to a local folder
in that folder,  run

```
sudo docker build -t theogdoctorg/conda-meep .
```
