# Kaltura Task

## Objective  
Build and deliver a simple nginx stack based on k8s

______________________________________________

## Requirements: 
1. Please create CI as following:

    - Create docker file, consist of nginx
    - the nginx need to publish your name and DOB as plain text
    - Please create a script to build and push the dockerfile in to Dockerhub

2. add deployment based on k8s yaml. 

	- the k8s deployment needs to utilize the nginx image built on the first phase.
	- We should reach the nginx from our computer browser using port 80

______________________________________________

## Required:

#### You need to set kubernetes cluster:

  - You can set minikube (instructions  are in the link : https://minikube.sigs.k8s.io/docs/start/ )

  OR

  - If you have docker desktop on your computer, enable kubernetes (https://docs.docker.com/desktop/kubernetes/)

#### You need to install the nginx ingress-controller:
  - Follow  the instructions in the link : https://kubernetes.github.io/ingress-nginx/deploy/#docker-desktop


______________________________________________

## In order to build & run:

#### To run the deployment:
```
kubectl apply -f deployment.yaml
```

#### run ingress file :
```
kubectl apply -f ingress.yaml
```

#### Then you can access the service using the URL: http://localhost/
you'll see :

<img width="700" alt="screenshot" src="screenshots/kaltura.png">


______________________________________________

## Solution explanation:
- ### Created a simple HTML file, named index.html , in order to present name & DOB. 
- ### Created Dockerfile :
   - For importing nginx image from dockerhub ( https://hub.docker.com/_/nginx )
   - Copy html file from the current dir to the nginx image
-  ### Created Jenkinsfile to build docker image and push it to Dockerhub :
   - The Jenkinsfile consists of Jenkins Pipeline ( cloning the project + build image + login to dockerhub +  push image)
   - In order to login to docker hub from jenkins I've created a new credential with my Docker Hub account details. 
   - created pipeline job in jenkins master
   - import Jenkinsfile from the git repo
      <img width="700" alt="screenshot" src="screenshots/jenkins.png">
   - Dockerhub repo 
      
      <img width="700" alt="screenshot" src="screenshots/dockerhub.png">
- ### Deployment based on k8s yaml :
   - Created yaml file named : deployment.yaml with service exposed by specifying a type in the ServiceSpec: ClusterIP (default) - (Exposes the Service on an internal IP in the cluster. This type makes the Service only reachable from within the cluster). and with port: 80 , targetPort: 80.
   - Then Createed an Ingress yaml file  (with path : / , by default the host is : localhost and with port 80 ), which runs on the same service of the deployment.
   Because Ingress is an object that allows access to Kubernetes services from outside the Kubernetes cluster, so after applyin the ingress.yaml , we can access the html file from outside the kubernetes cluster. (For more information: https://www.nginx.com/resources/glossary/kubernetes-ingress-controller/ )
   - Then applying the yaml files (deployment + ingress) ( As mentioned earlier at  " In order to build & run" section )


