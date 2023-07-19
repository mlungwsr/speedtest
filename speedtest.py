import os
import requests
import speedtest

# Get the InfluxDB configuration from environment variables
influxdb_url = os.environ["INFLUXDB_URL"]
influxdb_db = os.environ["INFLUXDB_DB"]
influxdb_user = os.environ["INFLUXDB_USER"]
influxdb_pwd = os.environ["INFLUXDB_PWD"]

# Run the speedtest and get the JSON object
st = speedtest.Speedtest()
result = st.results.dict()

# Convert the JSON object to line protocol
measurement = "speedtest"
tags = f"host={result['client']['ip']},isp={result['client']['isp']}"
fields = f"download={result['download']},upload={result['upload']},ping={result['ping']}"
line = f"{measurement},{tags} {fields}"

# Send the line protocol to InfluxDB using the HTTP API
url = f"{influxdb_url}/write?db={influxdb_db}&u={influxdb_user}&p={influxdb_pwd}"
response = requests.post(url, data=line)
