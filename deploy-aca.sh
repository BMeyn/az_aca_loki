#!/bin/bash

# Variables
RESOURCE_GROUP="loki-resource-group"
LOCATION="eastus"
CONTAINERAPPS_ENVIRONMENT="loki-environment"
LOKI_APP="loki-app"
PROMTAIL_APP="promtail-app"
LOKI_IMAGE="grafana/loki:2.2.1"
PROMTAIL_IMAGE="grafana/promtail:2.2.1"
LOKI_CONFIG_URL="https://raw.githubusercontent.com/grafana/loki/v2.2.1/cmd/loki/loki-local-config.yaml"
PROMTAIL_CONFIG_URL="https://raw.githubusercontent.com/grafana/loki/v2.2.1/clients/cmd/promtail/promtail-docker-config.yaml"

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create Container Apps environment
az containerapp env create --name $CONTAINERAPPS_ENVIRONMENT --resource-group $RESOURCE_GROUP --location $LOCATION

# Deploy Loki container
az containerapp create --name $LOKI_APP --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT --image $LOKI_IMAGE --target-port 3100 --ingress 'external' --cpu 0.5 --memory 1.0Gi --env-vars "LOKI_CONFIG_URL=$LOKI_CONFIG_URL"

# Deploy Promtail container
az containerapp create --name $PROMTAIL_APP --resource-group $RESOURCE_GROUP --environment $CONTAINERAPPS_ENVIRONMENT --image $PROMTAIL_IMAGE --target-port 9080 --ingress 'external' --cpu 0.5 --memory 1.0Gi --env-vars "PROMTAIL_CONFIG_URL=$PROMTAIL_CONFIG_URL"

# Configure networking
az containerapp ingress enable --name $LOKI_APP --resource-group $RESOURCE_GROUP --type external --target-port 3100
az containerapp ingress enable --name $PROMTAIL_APP --resource-group $RESOURCE_GROUP --type external --target-port 9080
