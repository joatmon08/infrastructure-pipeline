approle:
	vault login -method=github token="${GITHUB_TOKEN}"
	vault write -f auth/approle/role/infrastructure-pipeline/secret-id
