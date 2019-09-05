Image=tbutzer/sphinx
html:
	docker run\
           -v `pwd`:/home \
           ${Image} sphinx-build source build/html


webServer:
	docker run --name some-nginx -p 80:80 -v `pwd`/build/html:/usr/share/nginx/html:ro -d nginx

getip:
	aws ec2 describe-instances --region us-west-2 |grep Public


git:
	(cd /opt/iac && make)


bash:
	docker run -it -v `pwd`:/home tbutzer/sphinx bash


