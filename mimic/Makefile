docker:
	docker build -t mimic .

bash:
	docker run -it mimic bash
setup:
	pip3 install pipenv
	pipenv install --dev --skip-lock
test:
	pipenv run -- bash tests/scripts/unit_tests.sh
