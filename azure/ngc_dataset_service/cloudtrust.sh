#! /bin/sh

# Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# LicenseRef-NvidiaProprietary
#
# NVIDIA CORPORATION, its affiliates and licensors retain all intellectual
# property and proprietary rights in and to this material, related
# documentation and any modifications thereto. Any use, reproduction,
# disclosure or distribution of this material and related documentation
# without an express license agreement from NVIDIA CORPORATION or
# its affiliates is strictly prohibited.
# Please read the complete licese agreement at (https://github.com/NVIDIA/Cloud-Trust-Scripts/blob/main/license.pdf

# This script is to create cloud trust on Azure

set -e

subscriptionId=$(az account show --query id --output tsv)
entitlement="ngc_dataset_service"
display_name="NGC DataSet Service"

az role definition create --role-definition '{
    "Name": "Role_for_NVIDIA_${entitlement}",
    "Description": "This Role is created for NVIDIA ${display_name}",
    "Actions": [
        "Microsoft.Storage/*/write", "Microsoft.Compute/*/read"
    ],
    "AssignableScopes": ["/subscriptions/${subscriptionId}"]
}'


sp=$(az ad sp create-for-rbac --name NV-Trust-Broker-${entitlement} --role "Role_for_NVIDIA_${entitlement}" --scopes \/subscriptions\/${subscriptionId} --years 1)

appId=$(echo $sp | jq .appId | tr -d '"')
clientSecret=$(echo $sp | jq .password | tr -d '"')
clientSecretId=$(az ad app credential list --id $appId --query '[].keyId|[0]' --output tsv)
clientSecretExpiry=$(az ad app credential list --id $appId --query '[].endDateTime|[0]' --output tsv)
subscriptionId=$(az account show --query id --output tsv)
tenantId=$(az account show --query tenantId --output tsv)

echo -e "\n SubscriptionId $subscriptionId  \n TenantId       $tenantId    \n AppId       $appId    \n ClientSecret   $clientSecret   \n ClientSecretId    $clientSecretId     \n ClientSecretExpiry    $clientSecretExpiry"
