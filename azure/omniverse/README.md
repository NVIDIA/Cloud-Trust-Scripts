# Setting up NVIDIA Cloud Trust for Omniverse
Please read the license of this software at : [Nvidia Cloud Trust License](https://github.com/NVIDIA/Cloud-Trust-Scripts/blob/main/license.pdf) 

## Prerequisite
Make sure you have access to create roles and assign permissions.
The service principal will have following permissions:
* Storage Read
* Compute Read

## Setup

### Script execution
Run the script using the following format
> `sh cloudtrust.sh` 
This will create role and service principal in Azure and generate client credentials
## Verify

Please login to your NVIDIA Cloud Trust Account and verify the Cloud Trust.
Done!