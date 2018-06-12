%title: Dockerizing JavaScript Applications - Introduction
%author: Daniel Li
%date: 13 JUN 2018

-> # Agenda <-

^
* Deploy Application without Containers
^
* Problems with Manual Deployment
^

* What are Containers?
^
* What is Docker?
^

* Deploy Application with Docker
^
* How does Containers solve our Issues?

---

-> # Our Application <-

Consists of 3 components:

^
1. Database - Elasticsearch
^
2. Backend - Express
^
3. Frontend - Vanilla with Webpack
^

Providing 3 Functions:
^

1. *C* - Create JSON object
^
2. *R* - Read JSON objects
^
3. *D* - Delete JSON objects
^

---

-> # Manual Deployment <-

-> ## Install Node <-

    $ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    $ source ~/.bashrc
    $ nvm install node
    $ nvm use node
^

-> ## Install Elasticsearch <-

    $ sudo apt update && install default-jdk
    $ sudo echo ‘JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"’ >> /etc/environment
    $ source /etc/environment
    $ sudo dpkg -i elasticsearch-6.1.1.deb
    $ sudo systemctl start elasticsearch.service
    $ sudo systemctl enable elasticsearch.service
    $ sudo systemctl daemon-reload
^

-> ## Clone Repository <-

    $ git clone git@github.com:d4nyll/docker-demo-frontend.git frontend
    $ git clone git@github.com:d4nyll/docker-demo-backend.git backend
^

-> ## Install Dependencies <-

    $ npm install
^

-> ## Build Application (E.g. Webpack, Babel) <-

    $ npm run build
^

-> ## Run Application <-

    $ npm run start # Backend
    $ npm run serve # Frontend

---

-> # Verifying Deployment (Backend) <-
^

-> ## Get Existing Docs (None) <-

    $ curl localhost:3000
    []
^

-> ## Add New Doc <-

    $ curl localhost:3000 \
      -d  '{ "foo": "bar" }' \
      -H 'Content-Type: application/json'
    Qj3X3mMB1CBvywRc8Kuj
^

-> ## Get New Doc <-

    $ curl localhost:3000
    [{"foo":"bar"}]
^

-> ## Delete All Docs <-

    $ curl -X DELETE localhost:3000
    Data Deleted
^

-> ## Get Existing Docs (None) <-

    $ curl localhost:3000
    []

---

-> # Verifying Deployment (Frontend) <-

-> Open http://localhost:8080/ <-

---

-> # Cleanup <-

-> ## Stop Services <-

    $ sudo systemctl stop elasticsearch.service

-> ## Verify <-

    $ curl localhost:9200    # Elasticsearch
    $ curl localhost:3000    # Back-End
    $ curl localhost:8080    # Front-End

---

-> # Problems with Manual Deployment <-
^

-> ## Lack of Consistency <-
^
-> Work in teams - different OS / environment <-
^
-> “But it works on my machine!” <-
^


-> ## Lack of Independence <-
^
-> Libraries installed globally
^
-> Must use same library versions for all projects on machine
^


-> ## Time-Consuming <-
^
-> For each Environment (e.g. staging / production), we must repeat:
-> - Server Provisioning / Set-Up <-
-> - Update <-
^

-> ## Error-Prone <-
^
-> Humans are Humans <-
^

-> ## Downtime <-
^
-> Deploying on a single machine <-
^
-> Single Point of Failure (SPOF) <-
^


-> ## Lack of Version Control <-
^
-> Cannot Rollback Easily <-
^

---

       ______     ______     __   __     ______   ______     __     __   __     ______     ______     ______    
      /\  ___\   /\  __ \   /\ "-.\ \   /\__  _\ /\  __ \   /\ \   /\ "-.\ \   /\  ___\   /\  == \   /\  ___\   
      \ \ \____  \ \ \/\ \  \ \ \-.  \  \/_/\ \/ \ \  __ \  \ \ \  \ \ \-.  \  \ \  __\   \ \  __<   \ \___  \  
       \ \_____\  \ \_____\  \ \_\\"\_\    \ \_\  \ \_\ \_\  \ \_\  \ \_\\"\_\  \ \_____\  \ \_\ \_\  \/\_____\ 
        \/_____/   \/_____/   \/_/ \/_/     \/_/   \/_/\/_/   \/_/   \/_/ \/_/   \/_____/   \/_/ /_/   \/_____/ 
                                                                                                              

-> ## Method of Virtualization <-
^
-> Run applications in isolated environment <-
-> All dependencies installed
^

-> ## Virtual Machines (VMs) <-
^
-> Uses Hypervisor <-
^
-> Emulates Hardware <-
^

-> ## Linux Containers (LXC) <-
^
-> Linux Kernel Features <-
-> - cgroup - group processes, restrict resources
-> - namespace - package resources (e.g. PID, storage, network)
^
-> Runs on the OS's kernel <-

---

                                                                                                                
                      ##         .                                                                              
                  ## ## ##        ==            _____     ______     ______     __  __     ______     ______    
              ## ## ## ## ##    ===            /\  __-.  /\  __ \   /\  ___\   /\ \/ /    /\  ___\   /\  == \   
          /"""""""""""""""""\___/ ===          \ \ \/\ \ \ \ \/\ \  \ \ \____  \ \  _"-.  \ \  __\   \ \  __<   
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~   \ \____-  \ \_____\  \ \_____\  \ \_\ \_\  \ \_____\  \ \_\ \_\ 
          \______ o           __/                \/____/   \/_____/   \/_____/   \/_/\/_/   \/_____/   \/_/ /_/ 
              \    \         __/                                                                                
              \____\_______/                                                                                    
                                                                                                                


-> ## NOT a new container format <-
^
-> Does not re-invent the wheel <-
^

-> ## A standard for defining containers <-
^
-> Dockerfile <-
^

-> ## A standard for running containers <-
^
-> Docker Engine <-
^

-> ## A common place for sharing images <-
^
-> Docker Hub <-

---

-> # Working with Docker <-

## ## 1. Write a Dockerfile

    FROM node
    RUN npm install
    RUN npm run build
    CMD npm run serve
^

## 2. Build Image

    $ docker build .

               +-   +-------------------------+                  
               |    | Read-Only Layer         | RUN npm run build
               |    +-------------------------+                  
         Image |    | Read-Only Layer         | RUN npm install  
               |    +-------------------------+                  
               |    | Read-Only Layer         | FROM node        
               +-   +-------------------------+                  
^

## 3. Run Image

    $ docker run <image>

               +-   +-------------------------+                  
     Container |    | Thin Read/Write Layer   | CMD npm run serve
               +-   +-------------------------+                  
                    |      |     |      |     |                  
               +-   |-------------------------|                  
               |    | Read-Only Layer         | RUN npm run build
               |    +-------------------------+                  
         Image |    | Read-Only Layer         | RUN npm install  
               |    +-------------------------+                  
               |    | Read-Only Layer         | FROM node        
               +-   +-------------------------+                  

---

-> # Migration to Docker (Elasticsearch) <-
^

-> ## Manual Deployment <-

    $ sudo apt update && install default-jdk
    $ sudo echo ‘JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"’ >> /etc/environment
    $ source /etc/environment
    $ sudo dpkg -i elasticsearch-6.1.1.deb
    $ sudo systemctl start elasticsearch.service
    $ sudo systemctl enable elasticsearch.service
    $ sudo systemctl daemon-reload
^

-> ## Docker <-

    $ docker pull docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4
    $ docker run \
      -e "discovery.type=single-node" \
      -d \
      --name elasticsearch \
      -p 9200:9200 -p 9300:9300 \
      docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4

---

-> # Migration to Docker (Back-End) <-

-> ## Manual Deployment <-

    $ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    $ source ~/.bashrc
    $ nvm install node
    $ nvm use node
    $ git clone git@github.com:d4nyll/docker-demo-backend.git backend
    $ npm install
    $ npm run start
^

-> ## Docker <-
^

-> Write Dockerfile <-

    FROM node
    WORKDIR /root/
    COPY . .
    RUN npm install
    CMD npm run start
^

-> Build the Image <-

    $ docker build -t backend/basic .
^

-> Run Image <-

    $ docker run \
      -d \
      --name backend \
      --network=host \
      backend/basic

---

-> # Migration to Docker (Front-End) <-

-> ## Manual Deployment <-

    $ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    $ source ~/.bashrc
    $ nvm install node
    $ nvm use node
    $ git clone git@github.com:d4nyll/docker-demo-frontend.git frontend
    $ npm install
    $ npm run build
    $ npm run serve
^

-> ## Docker <-
^

-> Write Dockerfile <-

    FROM node
    WORKDIR /root/
    COPY . .
    RUN npm install
    RUN npm run build
    CMD npm run serve
^

-> Build the Image <-

    $ docker build -t frontend/basic .
^

-> Run Image <-

    $ docker run \
      -d \
      --name frontend \
      -p 8080:8080 \
      frontend/basic

---

-> # Verifying Deployment (Frontend) <-

-> Open http://localhost:8080/ <-

---

-> # Cleanup <-

-> $ docker stop frontend backend elasticsearch <-
-> $ docker rm frontend backend elasticsearch <-

---

-> # What Problems does Docker solve? <-
^

-> ## Provides Consistency <-
^
-> Have all dependencies <-
^
-> Self-contained <-
^
-> Portable - works on one, works everywhere <-
^

-> ## Provides Independence <-
^
-> Have all dependencies <-
^
-> Use different libraries version inside different containers <-
^

-> ## Saves Time <-
^
-> Many commands -> A few commands <-
^

-> ## Reduces Errors <-
^
-> Specified as Code <-
^

-> ## Step Towards Zero Downtime <-
^
-> Cluster Orchestration Tools E.g. Kubernetes <-
^
-> All use Containers <-
^


-> ## Version Control <-
^
-> Dockerfile
^
-> Easy Rollback <-

---

-> # Next Steps <-
^

-> ## Optimizing Docker Images <-
^
-> Using Multi-Stage Builds <-
^
-> Creating Microcontainers with Smith <-
^

-> ## Container / Cluster Orchestration <-
^
-> Docker Swarm / Kubernetes <-

---
    
             ______   __  __     ______     __   __     __  __    
            /\__  _\ /\ \_\ \   /\  __ \   /\ "-.\ \   /\ \/ /    
            \/_/\ \/ \ \  __ \  \ \  __ \  \ \ \-.  \  \ \  _"-.  
               \ \_\  \ \_\ \_\  \ \_\ \_\  \ \_\\"\_\  \ \_\ \_\ 
                \/_/   \/_/\/_/   \/_/\/_/   \/_/ \/_/   \/_/\/_/ 
                                                                  
                         __  __     ______     __  __             
                        /\ \_\ \   /\  __ \   /\ \/\ \            
                        \ \____ \  \ \ \/\ \  \ \ \_\ \           
                         \/\_____\  \ \_____\  \ \_____\          
                          \/_____/   \/_____/   \/_____/          
                                                                  
                                                                  
                                                                  