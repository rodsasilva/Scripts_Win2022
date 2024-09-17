# Verifique se o m�dulo PSWindowsUpdate est� instalado
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module -Name PSWindowsUpdate -Force
}

# Importe o m�dulo
Import-Module PSWindowsUpdate

# Defina a pol�tica de execu��o para permitir a execu��o de scripts
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Verifique se h� atualiza��es dispon�veis
$updates = Get-WindowsUpdate

# Filtre as atualiza��es importantes e de seguran�a
$importantUpdates = $updates | Where-Object {$_.MsrcSeverity -in ('Critical', 'Important')}

# Exiba um resumo das atualiza��es importantes
if ($importantUpdates) {
    Write-Host "H� $($importantUpdates.Count) atualiza��es importantes dispon�veis:" -ForegroundColor Yellow
    $importantUpdates | Select-Object Title, KBArticleID, MsrcSeverity | Format-Table
} else {
    Write-Host "N�o h� atualiza��es importantes dispon�veis." -ForegroundColor Green
}

# Pergunte se o usu�rio deseja instalar as atualiza��es
$installUpdates = Read-Host "Deseja instalar as atualiza��es agora? (s/n)"

if ($installUpdates -eq 's') {
    # Instale as atualiza��es importantes
    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
} else {
    Write-Host "Atualiza��es n�o instaladas." -ForegroundColor Gray
    }