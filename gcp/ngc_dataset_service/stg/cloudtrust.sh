#! /bin/sh

# Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# LicenseRef-NvidiaProprietary
#
# NVIDIA CORPORATION, its affiliates and licensors retain all intellectual
# property and proprietary rights in and to this material, related
# documentation and any modifications thereto. Any use, redevuction,
# disclosure or distribution of this material and related documentation
# without an express license agreement from NVIDIA CORPORATION or
# its affiliates is strictly prohibited.
# Please read the complete licese agreement at (https://github.com/NVIDIA/Cloud-Trust-Scripts/blob/main/license.pdf

# This script is to create cloud trust on Google Cloud

set -e

PROGNAME=$(basename "$0")

usage()
{
    cat <<EOF
Usage:    $PROGNAME PROJECT_ID SERVICE_ACCOUNT_NAME

Positional arguments:
    PROJECT_ID	GCP Project Id
    SERVICE_ACCOUNT_NAME	Service Account Name
EOF
}

# Verify script parameters
if [ $# -ne 2 ]; then
    echo "$PROGNAME: invalid operand(s)"
    usage
    exit 1
fi

PROJECT_ID=$1
SERVICE_ACCOUNT_NAME=$2

echo "Project is ${PROJECT_ID}"
echo "Service account name is ${SERVICE_ACCOUNT_NAME}"

#Enable GCP Service APIs
gcloud services enable compute.googleapis.com --project ${PROJECT_ID}
gcloud services enable storage-component.googleapis.com --project ${PROJECT_ID}

#Import Service Account in IAM
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member=serviceAccount:nvidia-cloud-trust@nv-cloudtrust-dev.iam.gserviceaccount.com --role=roles/iam.serviceAccountTokenCreator

#Create Service Account
gcloud iam service-accounts create ${SERVICE_ACCOUNT_NAME} --display-name="Cloud Trust Access Service Account" --project ${PROJECT_ID}

#Add  roles required for TAO
gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" --member=serviceAccount:nvidia-cloud-trust@nv-cloudtrust-dev.iam.gserviceaccount.com --role=roles/iam.serviceAccountTokenCreator --project $1

gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"  --role=roles/storage.admin
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"  --role=roles/compute.instanceAdmin


echo "Service Account is : ${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"