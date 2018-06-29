$location = Read-Host -Prompt $env:SystemDrive\Users\kmagg\Documents\
$Names = Import-Csv -Path $location

foreach($n in $Names)
{
    try {
        $Computer = [Net.Dns]::Resolve($n.NAME) | Select HostName,AddressList
        $IP =($Computer.AddressList).IPAddressToString
        New-Object PSObject -Property @{Name=$Computer.HostName; IPAddress=$IP} | Export-Csv -Path \Users\kmagg\Documents\Working.csv -NoTypeInformation -Append
    }
  
     catch {
        Write-Host "$($n.NAME) is unreachable."
        Write-Output -InputObject $n | Export-Csv -Path $env:SystemDrive\Users\kmagg\Documents\Unreachable.csv -Append -Encoding ASCII
    }
}
