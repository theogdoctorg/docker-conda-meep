conda init
bash ~/.bashrc
. ~/.bashrc
conda activate mp
# fix Vispy issue in notebooks
Xvfb :1 -screen 0 1024x768x24 &
export DISPLAY=:1
mkdir -p /home/host/notebooks
jupyter notebook --notebook-dir=/home/host/notebooks --ip='*' --port=8888 --no-browser --allow-root
