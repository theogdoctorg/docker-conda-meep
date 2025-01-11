sudo docker run -i -t -p 8888:8888  \
--mount type=bind,src=/home/garrison/Projects/dockertest,dst=/home/ \
theogdoctorg/conda-meep /bin/bash -c "conda init && bash ~/.bashrc && \
. ~/.bashrc &&  conda activate mp && jupyter notebook \
--notebook-dir=/home/notebooks --ip='*' --port=8888 \
--no-browser --allow-root"
