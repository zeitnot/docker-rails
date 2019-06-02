[![Build Status](https://travis-ci.org/zeitnot/docker-rails.svg?branch=master)](https://travis-ci.org/zeitnot/docker-rails)

##### Description
This repository is a playground for docerazing `Rails`, `Postgresql` and `Rspec` with docker compose.
The aim is creating a simple and robust development environment with docker compose and deploy the code
to production with the help of docker swarm.

##### Development
Run `docker-compose up -d` and wait for all services are run and functioning. In order to use the app
the db schema must be updated. `docker-compose exec rails rake db:setup` command will update the database and loads 
seed data. Now go to [http://localhost:3000](http://localhost:3000) and vote for some polls.

##### Deployment with VirtualBox as single node
1. `docker-machine create -d virtualbox node1` 
2. `eval $(docker-machine env node1)`
3. `docker swarm init --advertise-addr $(docker-machine ip node1)`
4. `docker stack deploy -c docker-stack.yml rails`

Wait until all services up. You could check status of services with `docker service ls` command. This would take
some time so be patient. Do not forget that we are using newly created image as docker host. To use your host's docker
as docker host just type `eval $(docker-machine env -u)`.

##### Deployment with VirtualBox as Swarm Cluster
Coming soon. 