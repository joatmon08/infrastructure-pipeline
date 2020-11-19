get-secret:
	vault login -method=github token="${GITHUB_TOKEN}"
	vault write -f auth/approle/role/infrastructure-pipeline/secret-id

check-azure-credentials:
	vault read infrastructure-pipeline/azure/creds/pipeline
	vault list sys/leases/lookup/infrastructure-pipeline/azure/creds/pipeline