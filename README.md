[![Build Status](https://travis-ci.org/zeitnot/docker-rails.svg?branch=master)](https://travis-ci.org/zeitnot/docker-rails)
# Docerazing Rails with Nginx and Postgresql
#### Description
This repository is a playground for docerazing `Rails`, `Postgresql`, `Nginx` and `Rspec` with docker compose.
The aim is creating a simple and robust development environment with docker compose and deploy the code
to production with the help of docker swarm. This rails app is a simple poll application. It is listing polls
and lets the user to vote for a poll. A user would vote only once with the same IP. 

#### Development
Run `$ docker-compose up -d` and wait for all services are run and functioning. In order to use the app
the db schema must be updated. `$ docker-compose exec rails rake db:setup` command will update the database and loads 
seed data. Now go to [http://localhost:3000](http://localhost:3000) and vote for some polls.

#### Deployment with VirtualBox as single node
1. `$ docker-machine create -d virtualbox node1` 
2. `$ eval $(docker-machine env node1)`
3. `$ docker swarm init --advertise-addr $(docker-machine ip node1)`
4. `$ docker stack deploy -c docker-stack.yml rails`

Wait until all services up. You could check status of services with `$ docker service ls` command. This would take
some time so be patient. 

Seed the database with `$ docker exec $(docker ps -lq --filter name=rails_rails) rake db:seed`.

Do not forget that we are using newly created image as docker host. To use your host's docker
as docker host just type `$ eval $(docker-machine env -u)`.

To view rails app in action we need to know our server's ip. `$ docker-machine ip node1` command gives us the public ip. 

#### Deployment with VirtualBox as Swarm Cluster
We will create 3 servers such as 1 manager and 2 worker nodes through VirtualBox. So let's create servers first.
1. `$ docker-machine create -d virtualbox node-1` 
2. `$ docker-machine create -d virtualbox node-2`
3. `$ docker-machine create -d virtualbox node-3`

We will use `node-1` as manager node. So type as the following:
1. `$ eval $(docker-machine env node-1)` We change the host as `node-1`
2. `$ docker swarm init --advertise-addr $(docker-machine ip node-1)`
3. `$ TOKEN=$(docker swarm join-token -q worker)`

Our manager node is ready. Now the next is to join worker nodes to manager node. So type as the following:
1. `$ eval $(docker-machine env node-2)`
2. `$ docker swarm join --token $TOKEN $(docker-machine ip node-1):2377`
3. `$ eval $(docker-machine env node-3)`
4. `$ docker swarm join --token $TOKEN $(docker-machine ip node-1):2377`
5. `$ eval $(docker-machine env node-1)`

Our swarm cluster is ready. `$ docker node ls` command shows likely the following output. 

| ID                   |  HOSTNAME     |       STATUS    | AVAILABILITY | MANAGER STATUS     |   ENGINE VERSION |
| -------------------- | ------------- | --------------- | ------------ | ------------------ | ---------------- | 
| dwirgheqrjnz *       |  node-1       |       Ready     | Active       |   Leader           |   18.09.6        |
| qnmsyvcjf7r56        |  node-2       |       Ready     | Active       |                    |   18.09.6        |
| w1vljpmj0rvcv        |  node-3       |       Ready     | Active       |                    |   18.09.6        |

We can deploy our `docker-stack.yml` file with
`$ docker stack deploy -c docker-stack.yml rails` command. This will take a considerable time so use `$ docker service ls` command 
constantly so as to see the status of services.

We are almost finish. Once all services up and running we need to seed the database with the following command:
- `$ docker exec $(docker ps -lq --filter name=rails_rails) rake db:seed`

Last, to see the cluster in action get the `node-1` machine ip with `$ docker-machine ip node-1` and visit 
the poll application. 

#### Deployment To AWS EC2 As Swarm Cluster
Deploying to AWS EC2 instances is a bit complicated. First of all, a custom [VPC](https://docs.aws.amazon.com/vpc/index.html)
with its subnets and routing tables must be created. [Here](https://docs.docker.com/docker-for-aws/faqs/#recommended-vpc-and-subnet-setup)
is a working configuration. I tested this configuration with `eu-west-2` region
and it worked.

Once the configuration is set up, the following command should create the manager 
instance: 

```shell 
$ docker-machine create -d amazonec2 \
--amazonec2-vpc-id <your vpc id> \
--amazonec2-subnet-id <your subnet id> \
--amazonec2-region <your region> \
--amazonec2-zone <your region zone> \
--amazonec2-security-group <your security group name> \
aws-manager-1
```

If this works in your scenario, you would apply to the same command in order
to create worker instances.

Once `manager` and `worker` instances are created, `ubuntu` user should be
added to docker group for every instances such as the following command:

`$ docker-machine ssh aws-manager "sudo usermod -a -G dokcer $USER"`

We can init swarm mode on our `manager` instance with `$ docker swarm init --advertise-addr eth0`. 
The rest of other things like joining workers is the same as the preceding 
virtualbox example. 
