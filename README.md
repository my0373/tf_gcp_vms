# Build an HA artifactory instance on GCP

Plan the deployment
```shell
terraform plan -var-file="testing.tfvars"
```
Apply the deployment
```shell
terraform apply -var-file="testing.tfvars" --auto-approve
```

SSH to the newly created instance
```shell
ssh -o StrictHostKeyChecking=no matthewy_myorg_com@postgres.mydomain.co.uk
```

When finished, destroy the environment
```shell
terraform destroy
```