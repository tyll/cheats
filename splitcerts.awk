# Run with awk -f thisfile.awk certs.pem
# Splits certificate bundles into single files
BEGIN { certnumber = 0 }
certdata { certdata = certdata "\n" $0 }
/----BEGIN/ {
    certdata = $0
    certnumber = certnumber + 1
    certfile = "cert" certnumber ".crt"
}
/----END/ && certdata {
    print certdata > certfile
    close(certfile)
    certdata = undefined
}
