<#
!ATEN��O! PARA EXECUTAR O PROCEDIMENTO PRECISA QUE TODOS OS SERVI�OS ESTEJAM
PARADOS E ALINHADO COM GUSTAVO OU ANDRE
1 - ACESSE VIA RDP O SERVIDOR SRVSEDE01504
2 - EM "Windows Powershell ISE"
3 - EM open c:\script\Compila_p12.ps1

#>

#Carrega instancia uma a uma
$copy = @()
$slv = @()
$stopservice = @()
$startservice = @()
$stoptarefas = @()
$dbaccess = $()
$vip = $()
########################################################################
#variavel modulo
$copy = "C:\Scripts\module\u_copia.ps1"
$slv = "C:\Scripts\module\u_slaves.ps1"
$stopservice = "C:\Scripts\module\u_stopservico.ps1"
$startservice = "C:\Scripts\module\u_startservico.ps1"
$dbaccess = "C:\Scripts\module\u_dbacess.ps1"
$vip = "C:\Scripts\module\u_vip.ps1"
#######################################################################
#importa��o de modulos
Import-Module $copy #copia do RPO
Import-Module $slv #Stop/Start de Slaves 1 ao 30
Import-Module $stopservice # Stop os servi�os do Cluster
Import-Module $startservice # Start os servi�os do Cluster 
Import-Module $dbaccess # Stop/Start dbaccess distribuido
Import-Module $vip # Coment�rio no ambiente VIP

##FASE - 1
###STOP SERVI�OS###
stopservico -servico 'EAI','PORTAIS','WS','WF','schedule','TSS','VIP', 'COMPILA' # Servi�o]
###STOP SERVI�OS ESB | Temporariamente##
Get-Service -Name "TOTVSESB" | Stop-Service -Force
###STOP DBACCESS DISTRIBUIDO###
dbaccess_stop
#STOP SERVI�OS DE SLAVES 1-46#
#Aten��o para Slave 46 | parar na m�o por enquanto
stopslave
#Stop - Slave 46
Get-Service -Name "TOTVSAPPSLV46_" | Stop-Service -Force
###FASE - 2
###Ambiente Compila
startservico -servico 'COMPILA'
dbaccess_start
#C�PIA DE RPO##
copia # os logs da execu��o fica localizado em c:\temp\ERP_
###dbcaccess###
dbaccess_start
###START SERVI�OS ####
startservico -servico 'EAI','WS','WF','schedule','TSS', 'VIP','PORTAIS'
###START SERVI�OS ESB | Temporariamente##
Get-Service -Name "TOTVSESB" | Start-Service
#START SERVI�OS DE SLAVES 1-46##
startSlave
#Start - Slave 46
Get-Service -Name "TOTVSAPPSLV46_" | Start-Service
#Comet�rio no ambiente VIP
#replace_vip
