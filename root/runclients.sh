#/bin/bash
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 9000
killall squeezelite
sleep 1
cset shield --cpu 1-3

squeezelite -a 128:128 -o equal -n Kuchyn -m "00:00:00:00:00:01" -z -p 99
squeezelite -a 128:128 -o equal2  -n Obyvak -m "00:00:00:00:00:02" -z -p 99
squeezelite -a 128:128 -o equal3  -n Loznice -m "00:00:00:00:00:03" -z -p 99

PID1=$(pgrep -f Loznice)
PID2=$(pgrep -f Kuchyn)
PID3=$(pgrep -f Obyvak)

echo $PID1
echo $PID2
echo $PID3

cset shield --shield --pid $PID1 --threads
cset shield --shield --pid $PID2 --threads
cset shield --shield --pid $PID3 --threads

taskset -acp 1 $PID1
taskset -acp 2 $PID2
taskset -acp 3 $PID3

sysctl -w kernel.sched_rt_runtime_us=-1

chrt -r -p 20 -a $PID1
chrt -r -p 20 -a $PID2
chrt -r -p 20 -a $PID3

cpupower frequency-set -f 480000
ethtool -s eth0 speed 100 duplex full
