#! /bin/bash

# sudo apt-get upadte

echo "Hello Tony" > /tmp/hellotony.txt

sudo hostname bighub1
echo "127.0.0.1 bighub1" >> /etc/hosts
sudo mkdir -p /opt

(cd /opt; git clone http://github.com/tonybutzer/jup)

sudo chown -R ubuntu /opt

# (cd /opt/jup/juphub/pkg; ./setup_os.sh)
