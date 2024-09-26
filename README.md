# az_aca_loki
Setup Loki log monitoring on container apps

## Prerequisites

Before running the `deploy-aca.sh` script, ensure you have the following:

- Azure CLI installed. You can install it using the `az-install.sh` script provided in this repository.
- An active Azure subscription.

## Deploying Loki and Promtail on Azure Container Apps

Follow these steps to deploy Loki and Promtail on Azure Container Apps using the `deploy-aca.sh` script:

1. Clone this repository to your local machine:
   ```sh
   git clone https://github.com/BMeyn/az_aca_loki.git
   cd az_aca_loki
   ```

2. Run the `deploy-aca.sh` script to create the necessary Azure resources and deploy Loki and Promtail:
   ```sh
   ./deploy-aca.sh
   ```

3. Verify that the Loki and Promtail containers are running in the Azure Container Apps environment:
   ```sh
   az containerapp list --resource-group loki-resource-group --output table
   ```

4. Access the Loki and Promtail services using the external IP addresses assigned to the containers. You can find the IP addresses by running:
   ```sh
   az containerapp show --name loki-app --resource-group loki-resource-group --query properties.configuration.ingress.fqdn
   az containerapp show --name promtail-app --resource-group loki-resource-group --query properties.configuration.ingress.fqdn
   ```

## Additional Information

For more information on configuring and using Loki and Promtail, refer to the official documentation:

- [Loki Documentation](https://grafana.com/docs/loki/latest/)
- [Promtail Documentation](https://grafana.com/docs/loki/latest/clients/promtail/)
