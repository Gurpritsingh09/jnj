#!bin/bash

echo " Entered into RBAC Permissions Setup "

user_group_type="$1"          # values have to be 'sp', 'group' or 'user'
user_group_name="$2"          #name for the given user_group_type
role="$3"                     #role for the given user_group_name (eg)Reader, Contributor etc
resource_type="$4"            #Is the resource type keyvault, storageaccount, resource group, ad group etc
resource_name="$5"            #name of the resource
additional_resource_name="$6" #For resources like fileshare since storage account name and fileshare name is needed or add user to group
objectId=""

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
    echo "There needs to be at least 5 parameters being inputed in the following format: 'user_group_type' 'user_group_name' 'role' 'resource_type' 'resource_name' 'additional_resource_name(optional)'"
    exit 1
else
    #Check if user type is sp
    if [ "$user_group_type" = "sp" ]; then
        objectId=$(az ad sp list --display-name "$user_group_name" --filter "displayname eq '$user_group_name'" | jq -r '.[].objectId') #fetch objectId value only
    #Check if user type is group
    elif [ "$user_group_type" = "group" ]; then
        objectId=$(az ad group list --display-name "$user_group_name" --filter "displayname eq '$user_group_name'" | jq -r '.[].objectId') #fetch objectId value only
    #user type is user otherwise
    else
        objectId=$(az ad user list --display-name "$user_group_name" --filter "displayname eq '$user_group_name'" | jq -r '.[].objectId') #fetch objectId value only
    fi

    if [ -z "$objectId" ]; then #check if the objectId is null
        echo " Failed to retrieve objectId for the "$user_group_name" and "$user_group_type", check if the inputs are valid names or exists "
        exit 1
    fi

    if [ "$resource_type" = "resourcegroup" ]; then #if resource type is resource group then fetch its id otherwise fetch ID for the resource

        resource_id=$(az group show --name "$resource_name" | jq -r '.id')

    elif [ "$resource_type" = "adgroup" ]; then

        echo "Assigning $user_group_name to adgroup: $resource_name"
        az ad group member add --group "$resource_name" --member-id "$objectId"
        exit 1

    else
        resource_id=$(az resource list --name "$resource_name" | jq -r '.[].id') #fetch Id value only and remove the first "/" out to use in az role command
    fi

    if [ -z "$resource_id" ]; then #check if the storage account resource id is null
        echo " Failed to retrieve Resource ID for the given resource name: "$resource_name" and resource type: "$resource_type", check if the resource name is valid or exists "
        exit 1
    fi

    if [ "$resource_type" = "keyvault" ]; then

        if [ "$role" = "Reader" ]; then
            az keyvault set-policy --name "$resource_name" --object-id "$objectId" --secret-permissions list get --key-permissions list get --certificate-permissions get getissuers list listissuers

        elif [ "$role" = "Contributor" ]; then
            az keyvault set-policy --name "$resource_name" --object-id "$objectId" --secret-permissions list get set delete --key-permissions list get update create import delete --certificate-permissions get getissuers list listissuers Update Create Import Delete
        fi

    elif [ "$resource_type" = "storageaccount" ]; then

        if [ ! -z "$additional_resource_name" ]; then #check if the user has passed the extra parameter for fileshare or container name

            file_name=$(az storage share show --account-name "$resource_name" --name "$additional_resource_name" --only-show-errors | jq -r '.name')

            if [ -z $file_name ]; then #check if filename is a blob if not a fileshare

                file_name=$(az storage container show --account-name "$resource_name" --name "$additional_resource_name" --only-show-errors | jq -r '.name')
                filetype="containers"

                if [ -z $file_name ]; then
                    echo "Please enter a valid fileshare or container name"
                    exit 1
                fi

            else
                filetype="fileshares"
            fi

            file_id="/fileServices/default/$filetype/${file_name}" #concat to get the full resource id
            resource_id=${resource_id}${file_id}
        fi
    fi

    role_exists=$(az role assignment list --role "$role" --assignee "$objectId" --scope "$resource_id" | jq -r '.[].name') #returns the name if role already exists
    #Check if role name returned is null or else Create the role assignment with the given values
    if [ -z "$role_exists" ]; then
        echo "Creating azure role assignment for user_group_name: "$user_group_name", role: "$role", resource type: "$resource_type" and resource name: "$resource_name" "
        az role assignment create --role "$role" --assignee "$objectId" --scope "$resource_id"
    else
        echo " Role "$role" already exists for assignee "$user_group_name" for the given resource type: "$resource_type" and resource name: "$resource_name" "$additional_resource_name" "
        exit 1
    fi
fi
