# Redox Storage Account deployment runbook

## Deployment prerequisites

- `EUN-DS-QA-VLT-hsdi` KeyVault access must be granted for `dsp-jenkins` service principal, otherwise SAS token won't be uploaded there during Jenkins job execution

## Deployment

1. Verify that `input.tfvars` file contains all the necessary (and proper) variable values
2. Run job for `1.storage-account-redox` directory (execute `run.sh` script)
3. Run job for `2.final-configs directory` (execute `run.sh` script)
