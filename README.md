# lab1-terraform

Abra o terminal e execute os comandos abaixo:
```
git clone https://github.com/eduappsec1/lab1-terraform.git
cd iac-security-lab
```

Para usar o Checkov
Baixe a imagem
```
docker pull bridgecrew/checkov:latest
```
Execute-o:
```
docker run --rm \
  -v "$PWD:/src" \
  bridgecrew/checkov:latest \
  -d /src/terraform \
  --framework terraform \
  --soft-fail
```
soft fail continua reportando os findings, mas retorna exit code 0


Testando o tfsec
```
docker pull aquasec/tfsec:latest
```
Executando o teste:
```
docker run --rm \
  -v "$PWD:/src" \
  aquasec/tfsec:latest \
  /src/terraform \
  --soft-fail
```

Executando KICS
```
docker pull checkmarx/kics:latest
```
```
docker run --rm \
  -v "$PWD:/path" \
  checkmarx/kics:latest \
  scan \
  -p /path/terraform \
  -t Terraform \
  --ignore-on-exit results
```
--ignore-on-exit results permite observar findings sem interromper o exercício. KICS documenta esse comportamento e também permite configurar a severidade que causa falha.
