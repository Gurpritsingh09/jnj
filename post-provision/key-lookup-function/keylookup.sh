#!bin/bash

keylookup() {

    name="$1"
    value=""
    value=`(grep -s "$name" ./env.properties || grep -s --include="env.properties" -r "$name" ./.. || grep -s "$name" ./../../env.properties || grep -s "$name" ./../../../env.properties) | tail -1` #check if value exists in current directory else serach one directory up and so on...
    value=`echo $value | cut -d"=" -f2`
    echo "$value"

}
