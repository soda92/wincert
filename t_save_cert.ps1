$Proxy=New-object System.Net.WebProxy
$WebSession=new-object Microsoft.PowerShell.Commands.WebRequestSession
$WebSession.Proxy=$Proxy
$attestedDoc = Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri http://169.254.169.254/metadata/attested/document?api-version=2020-09-01 -WebSession $WebSession
$signature = [System.Convert]::FromBase64String($attestedDoc.signature)
$cert = [System.Security.Cryptography.X509Certificates.X509Certificate2]($signature)
$cwd = (Get-Location).Path
[System.IO.File]::WriteAllBytes("$cwd\imds.crt", $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert))
