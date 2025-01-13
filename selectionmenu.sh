#!/bin/bash
# formatting functions
fwline() { printf "|"%78s"|\n" | tr " "  "$1"; }
pipecntr() { n=$((78-${#1})); m=$((n/2)); printf "|%$m"s"$1%$((m+n%2))"s"|\n"; }
piperpad() { n=$((78-${#1})); printf "| $1%$((n-1))"s"|\n"; }

# banner
fwline "="
pipecntr
pipecntr "Welcome to the Conda-Meep Docker Image!"
pipecntr
fwline "="
pipecntr "This image is intended to provide a cross-platform method"
pipecntr "of running Anaconda Python & Meep, the open-source FDTD"
pipecntr "simulation, with minimal setup and repeatable environments."
fwline "-"
piperpad "Please note that for Jupyter notebooks to work, port 8888 must be forwarded"
piperpad "into the host environemt during runtime. (-p 8888:8888 flag if using CLI)"
piperpad "Also note that using Spyder or any other GUI inside the container requires"
piperpad "X11 forwarding to be enabled and allowing connections on the host desktop."
piperpad "For more information, please see the documentation on Github at:"
piperpad "https://github.com/theogdoctorg/docker-conda-meep"
fwline "-"
# check if terminal is connected. Give user some help if not.
if [ ! -t 0 ] ; then
	fwline "~" 
	echo "ERROR!!!!!! No terminal connection detected."
	echo "This image needs to run with a terminal connect (interactive mode)"
	echo "in order to select the method of running Meep."
	echo "Please run this container from a  terminal/command prompt via the followiing command:"
	echo ""
	echo "docker run -it -p 8888:8888 --mount type=bind,src=<src>,dst=/home/host theogdoctorg/conda-meep"
	echo ""
	echo "where <src> is the path to the folder you would like to have accessible to Meep/Conda."
	fwline "~"
else
	echo "What launch method would you like to use for Meep/Anaconda?"
	op1="Single-Threaded Meep in  Jupyter Notebook"
	op2="Parallel (Open-MPI) Meep in  Jupyter Notebook"
	op3="Single-Threaded Meep with Spyder IDE (GUI)"
	op4="Parallel (Open-MPI) Meep with Spider IDE"
	op5="Open an Anaconda Python terminal"
	op6="Open a Bash shell (e.g. for Conda env changes, package install, etc.)"
	options=("$op1" "$op2" "$op3" "$op4" "$op5" "$op6" "Exit")
	select choice in "${options[@]}"
	do
		case $choice in # assuming everything is in /home/scripts/
			"$op1") exec /home/scripts/normal_jupyter.sh; break;;
			"$op2") exec /home/scripts/parallel_jupyter.sh; break;;
			"$op3") exec /home/scripts/normal_spyder.sh; break;;
			"$op4") exec /home/scripts/parallel_spyder.sh; break;;
			"$op5") exec python; break;;
			"$op6") exec bash; break;;
			"Exit") break;;
		esac
	done
fi
