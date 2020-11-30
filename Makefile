get-secret:
	vault write -field=secret_id -f auth/approle/role/infrastructure-pipeline/secret-id

check-aws-credentials:
	vault read -field=lease_duration infrastructure-pipeline/aws/creds/pipeline
	vault list sys/leases/lookup/infrastructure-pipeline/aws/creds/pipeline

get-database-password:
	vault read infrastructure-pipeline/database/creds/application

build-network:
	cd network && terraform init -backend-config=backend
	cd network && terraform apply

revoke:
	vault lease revoke -prefix infrastructure-pipeline/aws/creds