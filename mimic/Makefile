docker:
	docker build -t mimic .

bash:
	docker run -it -v `pwd`:/opt/cloudmapper mimic bash

run:
	docker run -it  -v `pwd`:/opt/cloudmapper mimic ./mimic.py collect --account demo

setup:
	pip3 install pipenv
	pipenv install --dev --skip-lock
test:
	pipenv run -- bash tests/scripts/unit_tests.sh
