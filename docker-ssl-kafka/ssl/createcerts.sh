#/bin/bash
rm -rf certs
mkdir certs
cd certs

echo "Generate server certs - CN mus be the same as the hostname"
keytool -keystore server.keystore.jks -alias localhost -validity 365 -genkey -storepass kafka123 -dname "cn=skytech-ubuntu,o=Cigna,c=COM"

echo "Generate Root CA x509 cert"
openssl req -new -x509 -keyout ca-key -out ca-cert -days 365 -subj '/CN=www.mydom.com/O=My Company Name/C=US' -passout pass:"kafka123"

echo "Generate trustsotre and import the root CA"

echo "yes" | keytool -keystore server.truststore.jks -alias CARoot -import -file ca-cert -storepass kafka123

echo "Export server cert to be signed"
keytool -keystore server.keystore.jks -alias localhost -certreq -file cert-file -storepass kafka123

echo "Use root CA to sign the server cert"
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:kafka123

echo "Import the root CA to keystore"
echo "yes" | keytool -keystore server.keystore.jks -alias CARoot -import -file ca-cert -storepass kafka123

echo "import the signed server cert to keystore"
echo "yes" | keytool -keystore server.keystore.jks -alias localhost -import -file cert-signed -storepass kafka123

cd ..

