#!/bin/bash
sudo apt-get update
sudo apt-get install findutils
sudo apt-get install coreutils
cd /usr/bin
sudo ln -s /usr/local/hive/bin/hive hive
sudo ln -s /usr/local/hive/bin/hive-config.sh hive-config.sh
sudo ln -s /usr/local/hive/bin/ext ext
cd $HOME
mkdir bb
cd bb
git clone https://github.com/intel-hadoop/Big-Data-Benchmark-for-Big-Bench.git
