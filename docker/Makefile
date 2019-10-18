Image=tbutzer/terraform

build:
	docker build --tag ${Image} .


push:
	docker login -u tbutzer
	docker push ${Image}

