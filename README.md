# Overview
This project deploy an ECS cluster and all the componenets needed to host a node web application. The whole infrastructure is deployed using **Terraform**. 
The project is implemented with modules and there is an environment defined **dev**. Each module will create the ressources needed to host the ECS cluster and the application itself. 
Module list: 
* **alb:** Creates the load balancer (application type) for the application 
* **ecs_app:** Creates the IAM roles, task and service needed to deploy the application into the ECS cluster using FARGATE
* **ecs_cluster:** Creates the cluster 
* **rds:** Creates a RDS MySQL DB linked to the application

Backend for this project is set to AWS S3 bucket. 

## Steps to deploy the application
1. Have a preconfigured user with the correct permissions to use AWS CLI. You can configure the user in AWS consosle following [this](https://www.simplified.guide/aws/iam/create-programmatic-access-user) tutorial. 
2. Configure the user created on step #1 to finally use AWS CLI without issues. You can perform this configuration following [this](https://www.simplified.guide/aws/cli/configure-on-linux-macos) tutorial
3. Clone the repository 
```
git clone git@github.com:cejas1719/nbcu-terraform-invfrav2.git
```
4. Go to `dev` folder 
5. Initialize the terraform project
```
terraform init
```
6. Create the plan 
```
terraform plan 
```
**NOTE: Please review carefully the described plan, as this is what terraform will do when you apply the changes**

7. Apply changes requiered
```
terraform apply 
```
