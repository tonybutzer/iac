build: pre
	pip3 install --user -e .

build2:
	pip install -e .

pip3:
	#sudo apt-get install python3-pip
	sudo yum install python36-pip -y

pre:	pip3
	mkdir -p ~/.aws
	echo "[default]" > ~/.aws/config
	echo "region = us-west-2" >> ~/.aws/config
	
