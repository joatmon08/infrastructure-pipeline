cert:
	openssl s_client -showcerts -connect ${VAULT_HOST} </dev/null 2>/dev/null|openssl x509 -outform PEM >ca.pem