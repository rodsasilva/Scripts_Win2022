$Name="Exemplo de escopo" 
$StartRange="172.16.54.2" 
$EndRange="172.16.54.254" 
$SubnetMask="255.255.255.0" 
$LeaseDuration="1.00:00:00" 
$ScopeId="172.16.54.0" # $(StartRange)-2
$ComputerName="exemplo.educa.sf" 
$DnsServer="172.16.107.2", "10.255.15.15" , "10.255.15.16" 
$DnsDomain="exemplo.sf" 
$Router="172.16.54.1" # $(StartRange)-1

Add-DhcpServerv4Scope -Name $Name -StartRange $StartRange -EndRange $EndRange -SubnetMask  $SubnetMask -LeaseDuration $LeaseDuration -State Active
Set-DhcpServerv4OptionValue -ScopeId $ScopeId -ComputerName $ComputerName -DnsServer $DnsServer -DnsDomain $DnsDomain -Router $Router -Force
