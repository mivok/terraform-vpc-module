.PHONY: init validate

validate: init
	AWS_REGION=us-east-1 terraform validate

init:
	terraform init

