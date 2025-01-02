

Structure:
```
.
├── site.yml
├── inventory.ini
├── group_vars/
│   └── all/
│       └── vault.yml
└── templates/
    ├── nginx.conf.j2
    └── gunicorn.service.j2
```
Create a vault file for secrets:

```
ansible-vault create group_vars/all/vault.yml
# Add the following:
vault_db_password: your_secure_password

```



Running the playbook:
```
# First time setup
ansible-playbook -i inventory.ini site.yml --ask-vault-pass

# Subsequent runs (idempotent)
ansible-playbook -i inventory.ini site.yml --ask-vault-pass
```

Verifying the deployment:
```
# Check component status
curl http://your_server_ip/healthcheck/
```

Expected response:
```
{
    "status": "healthy",
    "components": {
        "postgresql": "up",
        "nginx": "up",
        "django": "up"
    }
}
```
