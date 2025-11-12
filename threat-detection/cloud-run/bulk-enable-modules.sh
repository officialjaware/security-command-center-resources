#!/bin/bash

# Configuration file check
CONFIG_FILE="request.json"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "ERROR: '$CONFIG_FILE' not found in the current directory."
    echo "Please create the JSON configuration file and try again."
    exit 1
fi

# Function to apply configuration
apply_config() {
    local SCOPE_FLAG=$1
    local RESOURCE_ID=$2
    
    echo "------------------------------------------------"
    echo "Applying configuration to: $RESOURCE_ID"
    
    gcloud scc manage services update cloud-run-threat-detection \
        "$SCOPE_FLAG"="$RESOURCE_ID" \
        --enablement-state=ENABLED \
        --module-config-file="$CONFIG_FILE"

    if [ $? -eq 0 ]; then
        echo "SUCCESS: Updated $RESOURCE_ID"
    else
        echo "ERROR: Failed to update $RESOURCE_ID"
    fi
}

# Interactive Menu
echo "------------------------------------------------"
echo "SCCE Cloud Run Threat Detection Bulk Enable"
echo "------------------------------------------------"
echo "Select the scope for enablement:"
echo "1) Organization Level"
echo "2) Project Level (Single or Multiple)"
read -p "Enter choice [1 or 2]: " CHOICE

case $CHOICE in
    1)
        read -p "Enter Organization ID (numbers only): " ORG_ID
        if [[ -z "$ORG_ID" ]]; then
            echo "Error: Organization ID cannot be empty."
            exit 1
        fi
        apply_config "--organization" "$ORG_ID"
        ;;
    2)
        echo "Enter Project IDs separated by spaces."
        echo "Example: my-project-prod my-project-dev my-project-staging"
        read -p "Projects: " -a PROJECT_LIST
        
        if [ ${#PROJECT_LIST[@]} -eq 0 ]; then
            echo "Error: No projects entered."
            exit 1
        fi

        for PROJECT in "${PROJECT_LIST[@]}"; do
            apply_config "--project" "$PROJECT"
        done
        ;;
    *)
        echo "Invalid selection. Exiting."
        exit 1
        ;;
esac

echo "------------------------------------------------"
echo "Operation complete."