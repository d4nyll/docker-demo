%title: Dockerizing JavaScript Applications
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
^

* (Optimizing Docker Images)

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

    $ sudo apt update
    $ sudo apt install default-jdk
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

    $ yarn
^

-> ## Build Application <-

-> E.g. Webpack, Babel <-

    $ yarn run build
^

-> ## Run Application <-

    $ yarn run start

---

-> Verifying Deployment <-

