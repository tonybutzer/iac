init:
	docker run -i -t -v `pwd`/:/tfinfra tbutzer/terraform terraform init

apply:
	docker run -i -t -v `pwd`/:/tfinfra tbutzer/terraform terraform apply

destroy:
	docker run -i -t -v `pwd`/:/tfinfra tbutzer/terraform terraform destroy
	./renameDefunct.sh butzer-elastic1

bash:
	docker run -i -t -v `pwd`/:/tfinfra tbutzer/terraform bash
