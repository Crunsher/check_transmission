# check_transmission

## Installation and Dependencies

There are no special installation instructions, for details on Icinga 2
integration, see [Icinga](todo:link). The script uses transmission-remote
and assumes it to be installed.

## Usage
Transmission username and password are expected in the environment variable
"TR\_AUTH". Host is assumed to be localhost if "TR\_HOST is not set.

## Output
The output is formatted in a way for Icinga2 to understand. An exit code of 0
is set if the command is successful, 2 if it was unable to connect to the
transmission server and 3 if "TR\_AUTH" was not set.

## Icinga 2
`check_transmission.conf` contains a CheckCommand definition and a service
which is applied to all Hosts with `vars.transmission_auth` set. If
`vars.transmission_host` is set, it will be used, otherwise the plugin
defaults to `localhost:9091`.
