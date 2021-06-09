get-secret:
	vault write -field=secret_id -f auth/approle/role/infrastructure-pipeline/secret-id

check-aws-credentials:
	vault read -field=lease_duration infrastructure-pipeline/aws/creds/pipeline
	vault list sys/leases/lookup/infrastructure-pipeline/aws/creds/pipeline

get-database-password:
	vault read -field=username infrastructure-pipeline/database/creds/application
	vault list sys/leases/lookup/infrastructure-pipeline/database/creds/application

list-leases:
	vault list sys/leases/lookup/infrastructure-pipeline/aws/creds/pipeline
	vault list sys/leases/lookup/infrastructure-pipeline/database/creds/application

build-network:
	cd network && terraform init -backend-config=backend
	cd network && terraform apply

revoke:
	vault lease revoke -prefix infrastructure-pipeline/aws/creds
	vault lease revoke -prefix infrastructure-pipeline/database/creds
	vault lease revoke -prefix infrastructure-pipeline/terraform/creds


boundary-auth:
	boundary authenticate password -auth-method-id $(shell cd boundary && terraform output -raw boundary_auth_method_id) -login-name rosemary -password $(shell cd boundary && terraform output -raw boundary_operations_password)

ssh:
	boundary connect ssh -target-id=$(shell cd boundary && terraform output -raw boundary_target_runner) -username=ubuntu -- -i id_rsa