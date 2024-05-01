# com.app.flask-assignment
Code to create and build a basic flask app

## Application 
The application is written in python using flask and the application is running on port 5000.
The Dockerfile and all necessary files are present in app folder.

## Infrastructure
The infrastructure is deployed via terraform and the provider is AWS.
In order to deploy infra in your account, make below changes locally in your .aws/credentials and .aws/config file.

.aws/credentials
```bash
[xalts-assignment]
aws_access_key_id     = xxxx
aws_secret_access_key = xxxx
```
.aws/config
```bash
[profile xalts-assignment]
region = us-east-1
output = json
```

All the related code for the infrastructure deployment is present in environments/test folder and the base modules are written in modules folder

**NOTE:** **To test the API, you can do a GET call from postman/hit the url in any browser with the public ip of the instance followed by the port and path. 
i.e http://public_ip:5000/health**
