# Verifique se o módulo PSWindowsUpdate está instalado
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module -Name PSWindowsUpdate -Force
}

# Importe o módulo
Import-Module PSWindowsUpdate

# Defina a política de execução para permitir a execução de scripts
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Verifique se há atualizações disponíveis
$updates = Get-WindowsUpdate

# Filtre as atualizações importantes e de segurança
$importantUpdates = $updates | Where-Object {$_.MsrcSeverity -in ('Critical', 'Important')}

# Exiba um resumo das atualizações importantes
if ($importantUpdates) {
    Write-Host "Há $($importantUpdates.Count) atualizações importantes disponíveis:" -ForegroundColor Yellow
    $importantUpdates | Select-Object Title, KBArticleID, MsrcSeverity | Format-Table
} else {
    Write-Host "Não há atualizações importantes disponíveis." -ForegroundColor Green
}

# Pergunte se o usuário deseja instalar as atualizações
$installUpdates = Read-Host "Deseja instalar as atualizações agora? (s/n)"

if ($installUpdates -eq 's') {
    # Instale as atualizações importantes
    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
} else {
    Write-Host "Atualizações não instaladas." -ForegroundColor Gray
    }