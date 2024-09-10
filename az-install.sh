# cr# Überprüfen, ob curl installiert ist
if ! command -v curl &> /dev/null
then
    echo "curl wird installiert..."
    sudo apt-get update
    sudo apt-get install -y curl
fi

# Azure CLI installieren
echo "Azure CLI wird installiert..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Überprüfen, ob die Installation erfolgreich war
if command -v az &> /dev/null
then
    echo "Azure CLI wurde erfolgreich installiert."
else
    echo "Fehler bei der Installation der Azure CLI."


