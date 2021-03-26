# DevOps_PetClinic_app

## Contents
1. Brief
2. Project Planning
3. Risk Assessment
4. CI Pipeline
5. Docker/AWS ECR
6. Terraform
7. Kubernetes
8. Cost Breakdown
9. Team Members

## 1. Brief
This project is a DevOps Continuous Integration/Continuous Deployment pipeline for the Spring-PetClinic application library. It consists of two app repos; an angular front-end, and a RESTFUL API backend. 

The project aims to primarily utilize AWS services and be used as a learning point of the AWS infrastructure. The project will try to emulate a realistic private company tech stack, preferring private repositories to protect the companies code IP.

## 2. Project Planning
As a group we were all fairly new to the AWS technologies we were going to have to use in this project. and spent alot of the first week planning and researching and understanding the technologies we would need to use to complete the deployment of this application. As a team we had regulary catch ups on a daily basis discussing our findings and educating each other with what he found. Once we had done this we naturally assigned roles to each member of the team which was all pinned on the kanban board, as a team communication is essential to broaden knowledge and in order to get this project done in the most efficient way. So everybody had access to the board and could regularly update and monitor progress, the team were also communication via phone call, group chat and microsoft teams.

As a team we all knew each other fairly well. we used the Feynman Learning Technique approach when learning and planning this project.

1) Pretend to teach a concept you want to learn. Teaching each other the main components and technologies we would be using

2) Identify knowledge gaps in our explanation and filling these gaps in by researching and questioning each other and finding resources and researching until we could explain everything in basic terms.

3) Organize and simplify. As a team we all then had a fundamental understanding of the requirements of this project and how to execute we were able to organise this into exactly what needed to be done in chronological order from beginning to end and deploy each member with tasks to research further. This can be seen on the board.
"By the end of our first sprint, we hope to achieve a robust and secure end project, worked on equally by the team. If any member feels under pressure to achieve their tasks, we will all step in, as a team."

We ran stand-ups regularly through out the day with microsoft teams running all day. So anybody could communicate with another member at any time in order to keep track of the project timeline, and ensure empowerment and collaboration. We would review our kanban boards regulary to update and check off what each member had done and if something was not done able to support each other with this.

A regular flow of communication and having a kanban board was integral in completining this project efficiently as a team.

To see the actual Kanban Board:

[Link to Trello Board](https://github.com/users/OrigamiCranes/projects/2)

## 3. Risk Assessment
This is the risk assessment I have conducted for the project. 
Including replicas of the containers has reduced the chance of servers crashing causing a failure in the running of all services.
In addition including a load balancer means that the chance of traffic overload causing failure is also reduced.


![Risk Assessment](https://raw.githubusercontent.com/JasonWorger/T1_QA_Final_Project/master/.README_images/9c190a96.png)



## 4. CI Pipeline


* Kanban Board: github
* Version Control: AWS CodeCommit
* CI Server: AWS CodePipeline
* Infrastructure Management: Terraform
* Cloud server: Amazon Web Services (AWS)
* Containerisation: AWS ECR
* Orchestration Tool: Kubernetes
* Reverse Proxy: NGINX

![pipeline](https://d2908q01vomqb2.cloudfront.net/7719a1c782a1ba91c031a682a0a2f8658209adbf/2018/01/12/CD_to_K8-934x630.png)

The Project aimed to utilize AWS specific services for the CI/CD pipeline. AWS CodePipeline was used in this case. The pipeline is split into 3 stages; source, build and deploy. 

The source pulls the code from each of the AWS CodeCommit repositories, each repo is then tested & built in parallel. Upon the builds being complete, each docker image is pushed to their AWS ECR repository under the ‘Latest’ tag. 

Finally, the deployment occurs with the kubernetes EKS cluster being updated with the latest container images.
## 5. Docker/AWS ECR
In keeping with trying to use as many AWS services as possible for this project we used AWS ECR to store the Docker container images for the project.
## 6. Terraform 
Terraform allowed us to quickly create and destroy bespoke infrastructure to our project. This infrastructure was easily scalable and allowed us to make rapid needed changes which were applied immediately.
We successfully used Terraform to create the Elastic Kubernetes Services which comprised of a:

 - K8 Cluster
- 4 Nodes
- VPC
- Subnets
- Security Groups

The use of Terraform was paramount to this project and a key component to deploying the app successfully.
## 7. Kubernetes
We used EKSCTL to create the cluster with the required parameters. 

In order to make sure the cluster had the correct format we stored the information in a YAML file and created the cluster.

## 8. Cost Breakdown

![costs](https://trello-attachments.s3.amazonaws.com/6006b837abee6877e9b3597f/605db82e316f895cbe44b5ae/8f685cf3e49f5d496068e90abe92c415/WhatsApp_Image_2021-03-25_at_22.38.07.jpeg)   
   
## 9. Team Members
 * Jack McKeon
 * Kishan Vekaria
 * Bilal Mustafa
 * Suban Akhtar  


