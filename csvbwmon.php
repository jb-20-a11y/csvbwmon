<?php
if (array_key_exists("action",$_POST))
{
if ($_POST["action"]=="writemac")
{
get_result("/tmp/csvbwmon/cmd/csvbwmon write-mac",$_POST["content"]);
}
elseif ($_POST["action"]=="export")
{
$ret=get_result("/tmp/csvbwmon/cmd/csvbwmon export " . $_POST["directive"],NULL);
$dd="Bandwidth " . str_replace(":","_",$_POST["directive"]);
header("Content-length: " . strlen($ret));
header("Content-type: text/csv");
header("Content-disposition: attachment; filename=" . '"' . $dd . '"');
echo $ret;
}
else
{
}
die();	
}

function get_result($cmd,$stdin)
{
$descriptorspec = array(
0 => array("pipe", "r"),
1 => array("pipe", "w"),
);
$process = proc_open($cmd, $descriptorspec, $pipes);
if (is_resource($process)) {
if ($stdin!=NULL)
{
fwrite($pipes[0], $stdin);
}
}
fclose($pipes[0]);
$stdout = stream_get_contents($pipes[1]);
fclose($pipes[1]);
$return_value = proc_close($process);
return $stdout;
}
?><html>
<head>
<title>csvbwmon - Web GUI</title>
</head>
<body>
<h1>Welcome to the csvbwmon web GUI</h1>
<br />
<a href="usage.htm">View today's usage here</a>
<br />
<br />
<h2>Export CSV</h1>
<br />
Please input a date range with the beginning and end separated by a colon, in the format MM-DD-YY. Use cycle:MM-DD-YY to export the monthly cycle start on the specified date. Ex. 07-01-17:07-08-17 Ex. cycle:08-21-17 (would use 08-21-17:09-20-17). Use "current" for the current day's usage in this range.
<br />
<form method="post" action="csvbwmon.php" onsubmit="document.getElementById('exp_submit').disabled=true;">
<input type="hidden" name="action" value="export" />
<input type="text" name="directive" />
<br />
<input type="submit" id="exp_submit" value="Export" />
</form>
<br />
Please note that it will probably take a few minutes to process your request. Don't repeatedly press the button.
<br />
The resulting CSV file can be loaded in Excel or Calc and uses formulas to add the usage for each day and device. By default, the data is presented in GiB.
<br />
<br />
<h2>MAC Address</h1>
<br />
ma:ca:dd:re:ss:00=Device Name
<br />
<form method="post" action="csvbwmon.php">
<input type="hidden" name="action" value="writemac" />
<textarea name="content"><?php
echo get_result("/tmp/csvbwmon/cmd/csvbwmon read-mac",NULL);
?></textarea>
<br />
<input type="submit" value="Save" />
</form>
<br />
<br />
</body>
</html>