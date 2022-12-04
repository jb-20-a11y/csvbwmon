#!/bin/sh

PREFIX="csvbwmon"
INSTALL_TYPE=$(nvram get csvbwmon_type)
INSTALL_DIR=$(nvram get csvbwmon_dir)

hexget_resource () {
hexdump -ve '1/1 "%.2x\n"' "$1" > /tmp/comp_bash_$$.tmp
{
while IFS= read -r line
do
if [ $line != "" ]
then
l=$line
fi
echo -n "\x$l" >> /tmp/comp_out_$$.tmp
done < /tmp/comp_bash_$$.tmp
}
cat /tmp/comp_out_$$.tmp
rm /tmp/comp_bash_$$.tmp
rm /tmp/comp_out_$$.tmp
}

get_resource_name () {
g="$PREFIX"'_'"$1"
echo "$g"
}

load_resource () {
n=$(get_resource_name $1)
nn="$n"'_null'
if [ $INSTALL_TYPE = "file" ]
then
nb=$(cat "$INSTALL_DIR/$nn")
h=$(hexget_resource "$INSTALL_DIR/$n")
fi
if [ $INSTALL_TYPE = "nvram" ]
then
nb=$(nvram get $nn)
nvram get $n > /tmp/csvbwmon_init.tmp
h=$(hexget_resource "/tmp/csvbwmon_init.tmp")
rm /tmp/csvbwmon_init.tmp
fi
ns=$(echo "$nb" | sed -e "s/\\\\/\\\\\\\\/g")
r=$(echo -n "$h" | sed -e "s/$ns/\\\\0/g")
if [[ $3 = 0 ]]
then
echo -ne "$r" > "$2"
else
echo -ne "$r" > "/tmp/csvbwmon_init.tmp"
gzip -d -c "/tmp/csvbwmon_init.tmp" > "$2"
rm /tmp/csvbwmon_init.tmp
fi
}

get_config () {
[ -f /tmp/csvbwmon-conf.tmp ] && rm -f /tmp/csvbwmon-conf.tmp
if [ -z "$2" ]
then
load_resource config /tmp/csvbwmon-conf.tmp 0
cf="/tmp/csvbwmon-conf.tmp"
else
cf="$2"
cp "$cf" "/tmp/csvbwmon-conf.tmp"
fi
sed '/:/!d;/^ *#/d;s/:/ /;' < "$cf" | while read -r key val
do
if [ $key == $1 ]
then
echo "$val"
return
fi
done
echo -n ""
return
}

mkdir /tmp/csvbwmon
mkdir /tmp/csvbwmon/cmd
mkdir /tmp/csvbwmon/php
mkdir /tmp/csvbwmon/www
mkdir /tmp/csvbwmon/other
load_resource bulk "/tmp/csvbwmon/cmd/csvbwmon" 1
chmod +x "/tmp/csvbwmon/cmd/csvbwmon"
load_resource webgui "/tmp/www/csvbwmon.php" 1
chmod +x /tmp/www/csvbwmon.php
[ -f /tmp/newProfile ] && cat /tmp/newProfile > /tmp/preCSVProfile
[ -f /tmp/newProfile ] || cat /etc/profile > /tmp/newProfile
grep 'export PATH="/tmp/csvbwmon/cmd:$PATH"' /tmp/newProfile > /dev/null 2>&1
if [ $? -ne 0 ]
then
echo 'export PATH="/tmp/csvbwmon/cmd:$PATH"' >> /tmp/newProfile
fi
chmod +x /tmp/newProfile
mount --bind /tmp/newProfile /etc/profile
echo "$PATH" | grep "/tmp/csvbwmon/cmd" > /dev/null 2>&1
if [ $? -ne 0 ]
then
export PATH="/tmp/csvbwmon/cmd:$PATH"
fi

if [ $(get_config autostart) == "yes" ]
then
[ -f /tmp/cron.d/csvbwmon ] && /tmp/csvbwmon/cmd/csvbwmon restart > /dev/null 2>&1 || /tmp/csvbwmon/cmd/csvbwmon start > /dev/null 2>&1
fi

if [ $INSTALL_TYPE == "file" ]
then
ln -s "$(get_config datadir)/archive/" "/tmp/www/wrtbwmon"
fi
