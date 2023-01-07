# Attack API
This API allows you to send various types of attacks to a specified host and port, as well as manage a list of banned IP addresses and API keys. The Manager.sh script is a command-line interface that you can use to perform actions such as adding and removing attack methods, banning and unbanning IPs, and adding and removing API keys. The mainapi.php file is the main API script that receives requests and sends attacks based on the provided parameters. The api-keys.config, attack-methods.config, and banned-ips.config files are used to store the lists of API keys, attack methods, and banned IPs, respectively.

# Usage
Drag and drop the Manager.sh file into the root directory of your system and give it execute permissions (e.g. chmod +x Manager.sh).
Drag and drop the remaining files into the /var/www/html directory on your system.
Run the Manager.sh script using the ./Manager.sh command.
Follow the prompts to perform the desired actions.

#API Usage
To use the API, send a GET request to the mainapi.php script with the following parameters:

key: API key for authentication.
host: Host to send the attack to.
port: Port to send the attack to.
method: Attack method to use (e.g. UDP, SYN, FIN, ACK, RST, or PSH).
time: Duration of the attack in seconds.

#Examples

Here are some examples of using the API:

# Send a UDP attack to 192.168.1.1:80 for 10 seconds
curl "http://example.com/mainapi.php?key=APIKEY&host=192.168.1.1&port=80&method=UDP&time=10"

# Send a SYN attack to 10.0.0.1:443 for 60 seconds
curl "http://example.com/mainapi.php?key=APIKEY&host=10.0.0.1&port=443&method=SYN&time=60"

# Disclaimer
Use of this API for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state, and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program.
