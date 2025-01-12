conda init
bash ~/.bashrc
. ~/.bashrc
conda activate pmp
jupyter notebook --notebook-dir=/home/host/notebooks --ip='*' --port=8888 --no-browser --allow-root
