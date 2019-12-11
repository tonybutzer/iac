init:
	terraform init
initd:
	docker run -i -t -v `pwd`/:/tfinfra tbutzer/terraform terraform init

applyd:
	docker run -i -t -v `pwd`/:/tfinfra tbutzer/terraform terraform apply

destroyd:
	docker run -i -t -v `pwd`/:/tfinfra tbutzer/terraform terraform destroy
	./renameDefunct.sh butzer-little-big-hub1

bash:
	docker run -i -t -v `pwd`/:/tfinfra tbutzer/terraform bash
