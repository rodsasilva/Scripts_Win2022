<#
!ATENÇÃO! PARA EXECUTAR O PROCEDIMENTO PRECISA QUE TODOS OS SERVIÇOS ESTEJAM
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
#importação de modulos
Import-Module $copy #copia do RPO
Import-Module $slv #Stop/Start de Slaves 1 ao 30
Import-Module $stopservice # Stop os serviços do Cluster
Import-Module $startservice # Start os serviços do Cluster 
Import-Module $dbaccess # Stop/Start dbaccess distribuido
Import-Module $vip # Comentário no ambiente VIP

##FASE - 1
###STOP SERVIÇOS###
stopservico -servico 'EAI','PORTAIS','WS','WF','schedule','TSS','VIP', 'COMPILA' # Serviço]
###STOP SERVIÇOS ESB | Temporariamente##
Get-Service -Name "TOTVSESB" | Stop-Service -Force
###STOP DBACCESS DISTRIBUIDO###
dbaccess_stop
#STOP SERVIÇOS DE SLAVES 1-46#
#Atenção para Slave 46 | parar na mão por enquanto
stopslave
#Stop - Slave 46
Get-Service -Name "TOTVSAPPSLV46_" | Stop-Service -Force
###FASE - 2
###Ambiente Compila
startservico -servico 'COMPILA'
dbaccess_start
#CÓPIA DE RPO##
copia # os logs da execução fica localizado em c:\temp\ERP_
###dbcaccess###
dbaccess_start
###START SERVIÇOS ####
startservico -servico 'EAI','WS','WF','schedule','TSS', 'VIP','PORTAIS'
###START SERVIÇOS ESB | Temporariamente##
Get-Service -Name "TOTVSESB" | Start-Service
#START SERVIÇOS DE SLAVES 1-46##
startSlave
#Start - Slave 46
Get-Service -Name "TOTVSAPPSLV46_" | Start-Service
#Cometário no ambiente VIP
#replace_vip
