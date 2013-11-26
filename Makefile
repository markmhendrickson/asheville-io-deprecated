deps:
	@sudo pip install -r requirements.txt

run:
	@DEBUG=True python app.py

bootstrap:
	@python bootstrap.py

test:
	@ENVIRONMENT=test PYTHONPATH=. py.test -v test/

.PHONY: deps run test

