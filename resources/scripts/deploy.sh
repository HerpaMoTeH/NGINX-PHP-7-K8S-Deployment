#!/usr/bin/env bash

# Get current path and build service deployment path
current_path=$(pwd)
deployment_template_path="$current_path/../kubernetes/deployments/local-deployment-template.yaml"
variables_path="$current_path/../config/variables.sh"
deployment_file_path="$current_path/../tmp/local-deployment.yaml"


# import the configuration variables
source $variables_path
# Get the configuration variables (ones that end with _CONF)
variables=$(compgen -e | grep _CONF)

# Function which swaps the imported variable with its value inside the deployment script
swapVarWithValue()
{
    output="$1"

    for i in ${variables}
    do
        secondParam="${!i}"
        paramToSwap='$'"$i"
        output="${output/$paramToSwap/$secondParam}"
    done

    echo "$output"
}

# Create the temporary file
$(touch "$deployment_file_path")

# Read deployment script line by line and swap the variables with their values
while IFS='' read -r line || [[ -n "$line" ]]; do
    nline=$(swapVarWithValue "$line")
    $(echo "$nline" >> $deployment_file_path)
done < "$deployment_template_path"

# Build the deployemng creating command
create_deployment_command="kubectl create -f $deployment_file_path"

# Create the deployemnt
eval $create_deployment_command

# Delete the deployemnt file
$(rm $deployment_file_path)
