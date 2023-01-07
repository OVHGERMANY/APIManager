#!/bin/bash

# Declare arrays
declare -a APIKeys
declare -a attackMethods
declare -a bannedIPs

# Read configuration files
readConfig() {
  # Read API keys
  IFS=$'\n' read -d '' -r -a APIKeys < /var/www/html/Config/api-keys.config

  # Read attack methods
  IFS=$'\n' read -d '' -r -a readarray -t attackMethods < /var/www/html/Config/attack-methods.config

  # Read banned IPs
  IFS=$'\n' read -d '' -r -a bannedIPs < /var/www/html/Config/banned-ips.config
}

# Write configuration files
writeConfig() {
  # Write API keys
  printf "%s\n" "${APIKeys[@]}" > /var/www/html/Config/api-keys.config

  # Write attack methods
  printf "%s\n" "${attackMethods[@]}" > /var/www/html/Config/attack-methods.config

  # Write banned IPs
  printf "%s\n" "${bannedIPs[@]}" > /var/www/html/Config/banned-ips.config
}

# Display menu
displayMenu() {
  echo "1) List attack methods"
  echo "2) Add attack method"
  echo "3) Remove attack method"
  echo "4) List banned IPs"
  echo "5) Ban IP"
  echo "6) Unban IP"
  echo "7) List API keys"
  echo "8) Add API key"
  echo "9) Remove API key"
  echo "10) Quit"
}

# Display banned IPs
displayBannedIPs() {
  if [ ${#bannedIPs[@]} -eq 0 ]; then
    echo "No IPs banned"
  else
    echo "Banned IPs:"
    printf '%s\n' "${bannedIPs[@]}"
  fi
}
# Main loop
while true; do
  # Display menu and prompt for input
  displayMenu
  read -p "Enter option: " option

  # Process input
  case $option in
    1)
      # List attack methods
      if [ ${#attackMethods[@]} -eq 0 ]; then
        echo "No attack methods configured"
      else
        echo "Attack methods:"
        printf '%s\n' "${attackMethods[@]}"
      fi
      ;;
    2)
      # Add attack method
      read -p "Enter attack method: " attackMethod
      attackMethods+=("$attackMethod")
      writeConfig  # Write updated configuration to file
      echo "Attack method added"
      ;;
    3)
      # Remove attack method
      read -p "Enter attack method: " attackMethod
      if [[ " ${attackMethods[@]} " =~ " ${attackMethod} " ]]; then
        attackMethods=(${attackMethods[@]/$attackMethod/})
        writeConfig
        echo "Attack method removed"
      else
        echo "Error: Invalid attack method"
      fi
      ;;
    4)
      # List banned IPs
      displayBannedIPs
      ;;
    5)
      # Ban IP
      read -p "Enter IP to ban: " IP
      if [[ " ${bannedIPs[@]} " =~ " ${IP} " ]]; then
        echo "Error: IP already banned"
      else
        bannedIPs+=("$IP")
        writeConfig
        echo "IP banned"
      fi
      ;;
    6)
      # Unban IP
      read -p "Enter IP to unban: " IP
      if [[ " ${bannedIPs[@]} " =~ " ${IP} " ]]; then
        bannedIPs=(${bannedIPs[@]/$IP/})
        writeConfig
        echo "IP unbanned"
      else
        echo "Error: Invalid IP"
      fi
      ;;
    7)
      # List API keys
      if [ ${#APIKeys[@]} -eq 0 ]; then
        echo "No API keys configured"
      else
        echo "API keys:"
        printf '%s\n' "${APIKeys[@]}"
      fi
      ;;
    8)
      # Add API key
      read -p "Enter API key: " APIKey
            APIKeys+=("$APIKey")
      writeConfig
      echo "API key added"
      ;;
    9)
      # Remove API key
      read -p "Enter API key: " APIKey
      if [[ " ${APIKeys[@]} " =~ " ${APIKey} " ]]; then
        APIKeys=(${APIKeys[@]/$APIKey/})
        writeConfig
        echo "API key removed"
      else
        echo "Error: Invalid API key"
      fi
      ;;
    10)
      # Quit
      exit 0
      ;;
    *)
      # Invalid input
      echo "Error: Invalid option"
      ;;
  esac
done