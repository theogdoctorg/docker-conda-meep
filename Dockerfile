# plan: will only install Conda and any needed apt packages in this
# will use the conda environment file to install the remaining packages
FROM continuumio/miniconda3
# note: image appears to be Debian-based (Bookworm) with apt, bash, git
LABEL maintainer="theogdoctorg"

RUN apt-get update
RUN apt-get upgrade -y

# set up Conda environments first so they are cached if scripts need to change later 

# conda install steps taken from: https://meep.readthedocs.io/en/latest/Installation/ 
#RUN conda create --name mp -c conda-forge --file /home/general/condameep_req.txt -y 
ENV common_pkgs="matplotlib spyder jupyter numpy scipy vispy"
RUN conda create --name mp -c conda-forge $common_pkgs pymeep pymeep-extras -y
# .... seems to work better when run in one line
#RUN conda install -n mp -c conda-forge pymeep pymeep-extras -y

# RUN conda create --name pmp -c conda-forge --file /home/general/condameep_req.txt -y
RUN conda create -n pmp -c conda-forge $common_pkgs ipyparallel pymeep=*=mpi_mpich_* -y

# note: must be careful about running future "conda activate" commands, preceed cmd with:
# RUN conda init && bash ~/.bashrc && . ~/.bashrc
#  (reason: https://stackoverflow.com/questions/55123637/activate-conda-environment-in-docker)

# let Docker Desktop know Jupyter wants a port
EXPOSE 8888/tcp

# give the user a directory that is exposed to the host
RUN mkdir /home/host
VOLUME /home/host
#WORKDIR /home/

# set up selection menu
RUN mkdir /home/scripts
ADD normal_jupyter.sh /home/scripts
ADD parallel_jupyter.sh /home/scripts
ADD normal_spyder.sh /home/scripts
ADD parallel_spyder.sh /home/scripts
ADD selectionmenu.sh /home/scripts
ENTRYPOINT exec /home/scripts/selectionmenu.sh
#ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
