$Name="SSNBEN-SEG.PATRIMONIAL" 
$StartRange="172.16.100.130" 
$EndRange="172.16.100.254" 
$SubnetMask="255.255.255.128" 
$LeaseDuration="1.00:00:00" 
$ScopeId="172.16.100.128" 
$ComputerName="srvcstau0104.sfirjan.sf" 
$DnsServer="172.16.96.54", "10.255.15.13" 
$DnsDomain="sfirjan.sf" 
$Router="172.16.100.129" 

###


Add-DhcpServerv4Scope -Name $Name -StartRange $StartRange -EndRange $EndRange -SubnetMask  $SubnetMask -LeaseDuration $LeaseDuration -State Active
Set-DhcpServerv4OptionValue -ScopeId $ScopeId -ComputerName $ComputerName -DnsServer $DnsServer -DnsDomain $DnsDomain -Router $Router -Force
