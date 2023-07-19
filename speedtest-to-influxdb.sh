#!/bin/bash

# Run speedtest-cli and capture the JSON output
json_output=$(speedtest-cli --json)

# Extract the required fields from the JSON output (modify this based on your JSON structure)
download_speed=$(echo $json_output | jq -r '.download')
upload_speed=$(echo $json_output | jq -r '.upload')
ping=$(echo $json_output | jq -r '.ping')

# Send the data to InfluxDB using cURL (modify the parameters accordingly)
curl -i -XPOST 'http://influxdb-arm:8086/write?db=speedtest' --data-binary "speedtest,host=speedtest-influxdb download=$download_speed,upload=$upload_speed,ping=$ping"
