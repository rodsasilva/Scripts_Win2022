function Send-Office365Email {

    param (

        [string]$From,
        [string]$Password,
        [string]$To,
        [string]$Subject,
        [string]$Body

    )

    $SmtpServer = "smtp.office365.com"
    $Port = 587
    $Message = New-Object System.Net.Mail.MailMessage
    $Message.From = $From
    $Message.To.Add($To)
    $Message.Subject = $Subject
    $Message.Body = $Body
    $SmtpClient = New-Object System.Net.Mail.SmtpClient($SmtpServer, $Port)
    $SmtpClient.EnableSsl = $true
    $SmtpClient.Credentials = New-Object System.Net.NetworkCredential($From, $Password)
    try {

        $SmtpClient.Send($Message)

        Write-Host "E-mail enviado com sucesso!"

    }

    catch {

        Write-Host "Erro ao enviar e-mail: $_"

    }

    finally {

        $SmtpClient.Dispose()

    }

}
# Exemplo de uso
$From = "no-reply.v360@firjan.com.br"
$Password = "*********" # Senha da conta remetente
$To = "rodsasilva@firjan.com.br"
$Subject = "Teste de e-mail via Office 365"
$Body = "Este é um teste de envio de e-mail usando PowerShell e Office 365."
#teste de conexão com smtp-office 365
Test-NetConnection -Port 587 -ComputerName "smtp.office365.com"
Send-Office365Email -From $From -Password $Password -To $To -Subject $Subject -Body $Body