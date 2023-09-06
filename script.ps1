
$ipListFile = "path\to\file\ip_list.txt"
$fileToFind = "C:\file_to_find.txt"
$ipList = Get-Content -Path $ipListFile
foreach ($ip in $ipList) {
    
    if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
        $remotePath = "\\$ip\C$" 
        
        $fileOnRemote = Join-Path -Path $remotePath -ChildPath (Split-Path $fileToFind -Leaf)
        
        if (Test-Path -Path $fileOnRemote) {
            Write-Host "File found on $ip : $fileOnRemote"
        } else {
            Write-Host "File NOT found on $ip."
        }
    } else {
        Write-Host "$ip is offline or unreachable."
    }
}
