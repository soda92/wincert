$certs = Get-ChildItem '*.crt'
$storeLocation = "Cert:\LocalMachine\CA"

for($i=0; $i -ne $certs.Count; $i++) {
    $cert = $certs[$i].Name
    echo $cert
    try {
        Import-Certificate -FilePath $cert -CertStoreLocation $storeLocation
        Write-Output "Certificate imported successfully."
    }
    catch {
        Write-Error "Error importing certificate: $cert"
    }
}
