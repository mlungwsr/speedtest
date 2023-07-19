#!/bin/bash

# Run speedtest-cli and capture the JSON output
#json_output=$(speedtest-cli --json)
json_output='{"download": 9939293.721194586, "upload": 2486555.260160513, "ping": 42.484, "server": {"url": "http://jnb1.wiocc.net:8080/speedtest/upload.php", "lat": "-26.2044", "lon": "28.0456", "name": "Johannesburg", "country": "South Africa", "cc": "ZA", "sponsor": "WIOCC", "id": "12109", "host": "jnb1.wiocc.net:8080", "d": 28.566047531870637, "latency": 42.484}, "timestamp": "2023-07-19T01:45:58.502684Z", "bytes_sent": 4030464, "bytes_received": 14119132, "share": null, "client": {"ip": "129.232.219.207", "lat": "-26.3811", "lon": "27.8376", "isp": "xneelo", "isprating": "3.7", "rating": "0", "ispdlavg": "0", "ispulavg": "0", "loggedin": "0", "country": "ZA"}}'

# Extract the required fields from the JSON output (modify this based on your JSON structure)
download_speed=$(echo $json_output | jq -r '.download')
upload_speed=$(echo $json_output | jq -r '.upload')
ping=$(echo $json_output | jq -r '.ping')

# Send the data to InfluxDB using cURL (modify the parameters accordingly)
curl -i -XPOST 'http://influxdb-arm:8086/write?db=speedtest' --data-binary "speedtest,host=speedtest-influxdb download=$download_speed,upload=$upload_speed,ping=$ping"
