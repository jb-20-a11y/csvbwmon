#!/bin/sh

PREFIX="csvbwmon"
echo "Welcome to the csvbwmon setup script."
IFS= read -p "Please enter the fully-qualified path of the installation directory, or if you prefer, type nvram to use the NVRAM mode of this installation. " INSTALL_DIR
if [ ! -z "$INSTALL_DIR" ]
then
if [ "$INSTALL_DIR" == "nvram" ]
then
INSTALL_TYPE=nvram
echo "Proceeding with NVRAM mode installation."
else
INSTALL_TYPE=file
echo "Proceeding with external drive mode installation."
mkdir -p "$INSTALL_DIR" > /dev/null 2>&1
if [ ! -d "$INSTALL_DIR" ]
then
echo "Could not create $INSTALL_DIR"
exit
fi
fi
else
echo "Installation cancelled."
exit
fi

hexget_resource () {
hexdump -ve '1/1 "%.2x\n"' "$1" > /tmp/comp_bash_$$.tmp
{
while IFS= read -r line
do
if [ "$line" != "" ]
then
echo -n "\x$line" >> /tmp/comp_out_$$.tmp
fi
done < /tmp/comp_bash_$$.tmp
}
cat /tmp/comp_out_$$.tmp
rm -f /tmp/comp_bash_$$.tmp
rm -f /tmp/comp_out_$$.tmp
}

find_nobyte_r () {
hp0="aa"
hp1="ab"
hp2="ac"
hp3="ad"
hp4="ae"
hp5="af"
hp6="a0"
hp7="a1"
hp8="a2"
hp9="a3"
hp10="a4"
hp11="a5"
hp12="a6"
hp13="a7"
hp14="a8"
hp15="a9"
hp16="ba"
hp17="bb"
hp18="bc"
hp19="bd"
hp20="be"
hp21="bf"
hp22="b0"
hp23="b1"
hp24="b2"
hp25="b3"
hp26="b4"
hp27="b5"
hp28="b6"
hp29="b7"
hp30="b8"
hp31="b9"
hp32="ca"
hp33="cb"
hp34="cc"
hp35="cd"
hp36="ce"
hp37="cf"
hp38="c0"
hp39="c1"
hp40="c2"
hp41="c3"
hp42="c4"
hp43="c5"
hp44="c6"
hp45="c7"
hp46="c8"
hp47="c9"
hp48="da"
hp49="db"
hp50="dc"
hp51="dd"
hp52="de"
hp53="df"
hp54="d0"
hp55="d1"
hp56="d2"
hp57="d3"
hp58="d4"
hp59="d5"
hp60="d6"
hp61="d7"
hp62="d8"
hp63="d9"
hp64="ea"
hp65="eb"
hp66="ec"
hp67="ed"
hp68="ee"
hp69="ef"
hp70="e0"
hp71="e1"
hp72="e2"
hp73="e3"
hp74="e4"
hp75="e5"
hp76="e6"
hp77="e7"
hp78="e8"
hp79="e9"
hp80="fa"
hp81="fb"
hp82="fc"
hp83="fd"
hp84="fe"
hp85="ff"
hp86="f0"
hp87="f1"
hp88="f2"
hp89="f3"
hp90="f4"
hp91="f5"
hp92="f6"
hp93="f7"
hp94="f8"
hp95="f9"
hp96="0a"
hp97="0b"
hp98="0c"
hp99="0d"
hp100="0e"
hp101="0f"
hp102="01"
hp103="02"
hp104="03"
hp105="04"
hp106="05"
hp107="06"
hp108="07"
hp109="08"
hp110="09"
hp111="1a"
hp112="1b"
hp113="1c"
hp114="1d"
hp115="1e"
hp116="1f"
hp117="10"
hp118="11"
hp119="12"
hp120="13"
hp121="14"
hp122="15"
hp123="16"
hp124="17"
hp125="18"
hp126="19"
hp127="2a"
hp128="2b"
hp129="2c"
hp130="2d"
hp131="2e"
hp132="2f"
hp133="20"
hp134="21"
hp135="22"
hp136="23"
hp137="24"
hp138="25"
hp139="26"
hp140="27"
hp141="28"
hp142="29"
hp143="3a"
hp144="3b"
hp145="3c"
hp146="3d"
hp147="3e"
hp148="3f"
hp149="30"
hp150="31"
hp151="32"
hp152="33"
hp153="34"
hp154="35"
hp155="36"
hp156="37"
hp157="38"
hp158="39"
hp159="4a"
hp160="4b"
hp161="4c"
hp162="4d"
hp163="4e"
hp164="4f"
hp165="40"
hp166="41"
hp167="42"
hp168="43"
hp169="44"
hp170="45"
hp171="46"
hp172="47"
hp173="48"
hp174="49"
hp175="5a"
hp176="5b"
hp177="5c"
hp178="5d"
hp179="5e"
hp180="5f"
hp181="50"
hp182="51"
hp183="52"
hp184="53"
hp185="54"
hp186="55"
hp187="56"
hp188="57"
hp189="58"
hp190="59"
hp191="6a"
hp192="6b"
hp193="6c"
hp194="6d"
hp195="6e"
hp196="6f"
hp197="60"
hp198="61"
hp199="62"
hp200="63"
hp201="64"
hp202="65"
hp203="66"
hp204="67"
hp205="68"
hp206="69"
hp207="7a"
hp208="7b"
hp209="7c"
hp210="7d"
hp211="7e"
hp212="7f"
hp213="70"
hp214="71"
hp215="72"
hp216="73"
hp217="74"
hp218="75"
hp219="76"
hp220="77"
hp221="78"
hp222="79"
hp223="8a"
hp224="8b"
hp225="8c"
hp226="8d"
hp227="8e"
hp228="8f"
hp229="80"
hp230="81"
hp231="82"
hp232="83"
hp233="84"
hp234="85"
hp235="86"
hp236="87"
hp237="88"
hp238="89"
hp239="9a"
hp240="9b"
hp241="9c"
hp242="9d"
hp243="9e"
hp244="9f"
hp245="90"
hp246="91"
hp247="92"
hp248="93"
hp249="94"
hp250="95"
hp251="96"
hp252="97"
hp253="98"
hp254="99"
local sz="$1"
local st=$2
local ss="$3"
for index in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254
do
eval assign="\$hp$index"
oss="$ss"
ss="$ss\x$assign"
if [[ $st = 1 ]]
then
c=$(grep -c -F "$ss" "$sz")
ld="\x$assign"
c2=$(grep -c -F "$ld\x00" "$sz")
c3=$(grep -c -F "\x00$ld" "$sz")
c=$((c+c2+c3))
if [[ $c = 0 ]]
then
echo "$ss"
return
else
ss="$oss"
fi
else
p=$st
p=$((p-1))
r=$(find_nobyte_r "$sz" $p "$ss")
echo "$r"
return
fi
done
echo "none"
return
}

find_nobyte () {
echo $1 > /tmp/comp_hex_$$.tmp
i=0
r="none"
while [ $r == "none" ]
do
i=$((i+1))
r=$(find_nobyte_r "/tmp/comp_hex_$$.tmp" $i "")
done
rm -f /tmp/comp_hex_$$.tmp
echo $r
return
}


compress_resource () {
file="/tmp/comp_$$.tmp"
gzip -c "$1" > "$file"
x=$(hexget_resource "$file")
n=$(find_nobyte "$x")
b=$(echo "$n" | sed -e "s/\\\\/\\\\\\\\/g")
y=$(echo "$x" | sed -e "s/\\\\x00/$b/g")
rm -f "$file"
echo $n >> "$file"
echo $y >> "$file"
echo "$file"
}

binary_resource () {
file="/tmp/comp_$$.tmp"
cp "$1" "$file"
x=$(hexget_resource "$file")
n=$(find_nobyte "$x")
b=$(echo "$n" | sed -e "s/\\\\/\\\\\\\\/g")
y=$(echo "$x" | sed -e "s/\\\\x00/$b/g")
rm -f "$file"
echo $n >> "$file"
echo $y >> "$file"
echo "$file"
}

nvram_install_set () {
echo "#!/bin/sh" > /tmp/comp-nvram.sh
echo -n "nvram set $1='" >> /tmp/comp-nvram.sh
if [[ $3 = 1 ]]
then
c=$(echo -n "$2" | sed -e "s/\\\\x27/\\\\x27\\\\x22\\\\x27\\\\x22\\\\x27/g")
echo -ne "$c" >> /tmp/comp-nvram.sh
else
c="$2"
echo -n "$c" >> /tmp/comp-nvram.sh
fi
echo "'" >> /tmp/comp-nvram.sh
echo "nvram commit" >> /tmp/comp-nvram.sh
sh /tmp/comp-nvram.sh
rm -f /tmp/comp-nvram.sh
}

get_resource_name () {
g="$PREFIX"'_'"$1"
echo "$g"
}

write_nullbit () {
n=$(get_resource_name $1)
n="$n"'_null'
if [ $INSTALL_TYPE = "file" ]
then
echo -n "$2" > "$INSTALL_DIR/$n"
fi
if [ $INSTALL_TYPE = "nvram" ]
then
nvram_install_set "$n" "$2" 0
fi
}

write_body () {
n=$(get_resource_name $1)
if [ $INSTALL_TYPE = "file" ]
then
echo -ne "$2" > "$INSTALL_DIR/$n"
fi
if [ $INSTALL_TYPE = "nvram" ]
then
nvram_install_set "$n" "$2" 1
fi
}

save_text_resource () {
x=$(hexget_resource "$2")
write_nullbit "$1" '\x00'
write_body "$1" "$x"
}

save_binary_resource () {
f=$(binary_resource "$2")
{
i=0
while IFS= read -r line
do
if [[ $i = 0 ]]
then
write_nullbit "$1" "$line"
fi
if [[ $i = 1 ]]
then
write_body "$1" "$line"
fi
i=$((i+1))
done < "$f"
}
}

save_compressed_resource () {
f=$(compress_resource "$2")
{
i=0
while IFS= read -r line
do
if [[ $i = 0 ]]
then
write_nullbit "$1" "$line"
fi
if [[ $i = 1 ]]
then
write_body "$1" "$line"
fi
i=$((i+1))
done < "$f"
}
}

echo "Compressing and copying files..."

save_compressed_resource webgui csvbwmon.php
save_compressed_resource bulk csvbwmon
save_text_resource init init.sh
nvram set csvbwmon_type="$INSTALL_TYPE"
nvram set csvbwmon_dir="$INSTALL_DIR"
nvram commit
echo "You will be asked a series of questions for the default configuration. For a yes/no question, press y or n. For a fill in question, to take the default value, press Enter."
read -p "Do you want csvbwmon to start automatically (recommended)? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "autostart: yes" > /tmp/comp_conf.tmp
else
echo "autostart: no" > /tmp/comp_conf.tmp
fi
if [ $INSTALL_TYPE == "file" ]
then
echo "test"
IFS= read -p "Enter path for data. [default: $INSTALL_DIR/data] " datapath
if [ -z "$datapath" ]
then
echo "datadir: $INSTALL_DIR/data" >> /tmp/comp_conf.tmp
else
echo "datadir: $datapath" >> /tmp/comp_conf.tmp
fi
fi
if [ $INSTALL_TYPE == "nvram" ]
then
IFS= read -p "Enter minimum free space of NVRAM (in bytes) to prevent old archives from being deleted. [default: 5000] " minram
if [ -z "$minram" ]
then
echo "min-free-nvram: 5000" >> /tmp/comp_conf.tmp
else
echo "min-free-nvram: $minram" >> /tmp/comp_conf.tmp
fi
fi
IFS= read -p "Please enter the time (hh:mm) when a new archive starts each day. [default: 00:00] " archtime
if [ -z "$archtime" ]
then
echo "archive-time: 00:00" >> /tmp/comp_conf.tmp
else
echo "archive-time: $archtime" >> /tmp/comp_conf.tmp
fi
read -p "Do you want to use binary units for data measurements (1024 as a base instead of 1000)? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "use-binary: yes" >> /tmp/comp_conf.tmp
else
echo "use-binary: no" >> /tmp/comp_conf.tmp
fi
echo "mac-000000000000: Router" >> /tmp/comp_conf.tmp
echo "current: $(date +"%m-%d-%y")" >> /tmp/comp_conf.tmp
save_text_resource config /tmp/comp_conf.tmp
rm -f /tmp/comp_conf.tmp
echo "Configuration complete."
echo "Hooking into rc_startup..."
nvram get rc_startup > /tmp/rc_$$.tmp
x="true"
while IFS= read -r line
do
if [ "$line" == "# BEGIN_CSVBWMON_INIT" ]
then
x="false"
fi
if [ $x == "true" ]
then
echo "$line" >> /tmp/rc_new_$$.tmp
fi
if [ "$line" == "# END_CSVBWMON_INIT" ]
then
x="true"
fi
done < /tmp/rc_$$.tmp
rm -f /tmp/rc_$$.tmp
if [ -f /tmp/rc_new_$$.tmp ]
then
y=$(hexget_resource /tmp/rc_new_$$.tmp)
nvram_install_set "rc_startup" "$y" 1
rm -f /tmp/rc_new_$$.tmp
else
nvram set rc_startup=""
fi
nvram get rc_startup > /tmp/rc_$$.tmp
echo >> /tmp/rc_$$.tmp
echo "# BEGIN_CSVBWMON_INIT" >> /tmp/rc_$$.tmp
if [ $INSTALL_TYPE == "file" ]
then
echo '[ -d "$(nvram get csvbwmon_dir)" ] && chmod +x "$(nvram get csvbwmon_dir)/csvbwmon_init" && sleep 3 && sh "$(nvram get csvbwmon_dir)/csvbwmon_init"' >> /tmp/rc_$$.tmp
else
echo 'nvram get csvbwmon_init > /tmp/csvbwmon_init_script.sh && chmod +x /tmp/csvbwmon_init_script.sh && sleep 3 && sh /tmp/csvbwmon_init_script.sh && rm -f /tmp/csvbwmon_init_script.sh' >> /tmp/rc_$$.tmp
fi
echo "# END_CSVBWMON_INIT" >> /tmp/rc_$$.tmp
rt=$(hexget_resource /tmp/rc_$$.tmp)
nvram_install_set "rc_startup" "$rt" 1
rm -f /tmp/rc_$$.tmp
echo "Installation finished. Now the service will be initialized."
sh ./init.sh
