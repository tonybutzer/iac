#! /bin/bash

# sudo apt-get upadte

echo "Hello Tony" > /tmp/hellotony.txt

sudo hostname worker2
echo "127.0.0.1 worker2" >> /etc/hosts
sudo mkdir -p /opt

(cd /opt; git clone http://github.com/tonybutzer/djup)

sudo mkdir -p /data; sudo chown ubuntu /data

sudo chown -R ubuntu /opt

(cd /opt/djup/pkg; ./setup_os.sh)
