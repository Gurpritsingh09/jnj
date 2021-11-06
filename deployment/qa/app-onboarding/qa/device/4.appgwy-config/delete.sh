
chmod +x cleanup.sh

for function in $(cat azure-functions.properties); do
    function_resource_name=$(echo $function | cut -d "=" -f1)
    function_name=$(echo $function | cut -d "=" -f2)

    echo " Clean Application Gateway for function : $function_name "
    ./cleanup.sh $function_name $function_resource_name
done
