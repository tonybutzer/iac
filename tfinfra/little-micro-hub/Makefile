init:
	terraform init

apply:
	terraform apply

destroy:
	terraform destroy
	./renameDefunct.sh butzer-little-big-hub1

awsregion:
	# mkdir ~/.aws
	chmod 700 ~/.aws
	echo '[default]' > ~/.aws/config
	echo "region = us-west-2" >> ~/.aws/config


git:
	(cd /opt/iac; make)
