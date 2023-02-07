# Setting up NVIDIA Cloud Trust for Unified Cluster Lifecycle
Please read the license of this software at : [Nvidia Cloud Trust License](https://github.com/NVIDIA/Cloud-Trust-Scripts/blob/main/license.pdf) 

## Prerequisite
Make sure you have access to create roles and assign permissions.
The service account will have following permissions:
* Read/Write Storage

## Setup

### Script execution
Run the script using the following format
> `sh cloudtrust.sh <gcp_project_id> <service_account_name>` 

1. `gcp_project_id` : GCP Project ID
2. `service_account_name` : Service Account Name

For example:
> `sh cloudtrust.sh 123456 service_account_name`

## Verify

Please login to your NVIDIA Cloud Trust Account and verify the Cloud Trust.
Done!