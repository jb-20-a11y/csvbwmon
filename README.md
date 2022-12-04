# csvbwmon: Bandwidth Monitoring Script for WRT Routers
Based off [Bandwidth Monitoring Script from Emmanuel Brucy](https://gist.github.com/hduffddybz/688c74f4157fe29b84fb)

This shell script utilizes iptables filters to record the Internet bandwidth usage of connected devices on the router on a per-MAC address basis.

Modifications include:
* Renamed chain from RRDIPT to BWMON
* Monthly cycle capability
* Publish to CSV (using formulas to retain precision)
* Add numbers using shell function that allows infinite integer length so exact byte counts can be recorded
* Light web GUI
* Better ARP handling (record devices no longer alive)

## Installation
Extract this folder into a directory, run `install.sh`, and follow the prompts.

External drive installation is preferred and the only method that has been tested. The install script will utilize this information to construct a startup script accordingly so that it functions like a background service.

## Usage
Call `csvbwmon get|set` to change configuration options.

Browse to `/tmp/www/usage.htm` in a web browser running a live installation to see usage statistics by MAC address for the current day (legacy feature).

Browse to `/tmp/www/csvbwmon.php` in a web browser running a live installation in order to export usage statistics to CSV over a selected date range in MM-DD-YY format. Use cycle:MM-DD-YY to export the monthly cycle starting on the specified date. Ex. 07-01-17:07-08-17 Ex. cycle:08-21-17 (would use 08-21-17:09-20-17). Use "current" for the current day's usage in this range. Alternatively, call `csvbwmon export [DATE-RANGE]` to output CSV to stdout.

Likewise, in the web GUI, adjust the names of devices given to each MAC address. In the command-line, call `csvbwmon` with the option `get-mac [MAC]` or `set-mac [MAC] [name]` to achieve the same result.