# Ejemplo: Uso de recursos entre cuentas mediante Lambda
En este ejemplo tenemos una **Lambda** llamada **get-app-version** que se encuentra en desplegada en la **Cuenta A** que su funcionalidad es obtener la versión desde un objeto guardado en una tabla de **DynamoDB** llamada **app-settings** que se encuentra desplegada en la **Cuenta B**.

## Requerimientos para el uso de este repositorio
- 2 cuentas distintas para la prueba
- Terraform para la IaC
- Node.js 20.x
- NPM
- Paquete de zip

## Pasos para el despliegue
### 1. Definición de número de cuentas de AWS
En el directorio raíz del ejemplo, se debe modificar y colocar en las variables los números correspondientes a las cuentas en el archivo: `env.tfvars`

**# Se debe realizar este paso para que los siguientes funcionen correctamente.**

### 2. Inicialización de lambda
Desde la carpeta raiz del ejemplo:
```sh
example > cd ./account-a/lambda 
example/account-a/lambda > npm install
```

### # Compilación de lambda
Este paso es opcional, ya que es posible hacerlo de manera manual, este script se encarga únicamente de comprimir todo los archivos de la carpeta lambda y convertirlos en un .zip y poderlo subir automaticamente con el script.
```sh
example > chmod +x compress-lambda.sh # Dar permisos para ejecutar el script
example > ./compress-lambda.sh
```

### 3. Credenciales de la Cuenta A
Puedes usar aws-cli para colocar las credenciales o utilizar algún método de autentificación, donde defina las variables **AWS_ACCESS_KEY_ID**, **AWS_SECRET_ACCESS_KEY**

### 4. Despliegue de la Cuenta A
Desde la carpeta raiz del ejemplo:
```sh
example > cd ./account-a 
example/account-a > tf apply --auto-approve --var-file="../env.tfvars"
```

### 5. Credenciales de la Cuenta B
Puedes usar aws-cli para colocar las credenciales o utilizar algún método de autentificación, donde defina las variables **AWS_ACCESS_KEY_ID**, **AWS_SECRET_ACCESS_KEY**

### 6. Despliegue de la Cuenta B
Desde la carpeta raiz del ejemplo:
```sh
example > cd ./account-b
example/account-b > tf apply --auto-approve --var-file="../env.tfvars"
```
