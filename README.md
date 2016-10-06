# salt-playground
Instant multihost Salt environment fired up with Compose

# Requirements
* A Docker host, either local or remote
  * [Mac users](https://docs.docker.com/docker-for-mac/)
  * [Linux users](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
  * [Docker Machine](https://docs.docker.com/machine/install-machine/)
* Docker Compose:
  * Mac users: `brew install docker-compose`
  * Universal: 
  
```
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` \
> /usr/local/bin/docker-compose
```
  
# Usage
1. `cd salt-playground`
2. `docker-compose -f demo.yml up --build --remove-orphans --force-recreate -d`
3. Wait and have a coffee ☕️

```
$ docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                              NAMES
2c0c7a75b253        openstackdemo_master         "/root/start.sh 6"       9 minutes ago       Up 9 minutes        0.0.0.0:4505-4506->4505-4506/tcp   salt-master
3536c4ebd833        openstackdemo_compute01      "/root/wait-for-minio"   9 minutes ago       Up 9 minutes                                           compute01
ed13fb6d5045        openstackdemo_controller01   "/root/wait-for-minio"   9 minutes ago       Up 9 minutes                                           controller01
8ba9b601aa1c        openstackdemo_compute02      "/root/wait-for-minio"   9 minutes ago       Up 9 minutes                                           compute02
a68d9515ea90        openstackdemo_controller03   "/root/wait-for-minio"   9 minutes ago       Up 9 minutes                                           controller03
49cafd4611c9        openstackdemo_web01          "/root/wait-for-minio"   9 minutes ago       Up 9 minutes                                           web01
99350c48af7b        openstackdemo_controller02   "/root/wait-for-minio"   9 minutes ago       Up 9 minutes                                           controller02
```

Then get the master ID, like ***2c0c7a75b253***

```
$ docker exec -ti 2c0c7a75b253 bash
root@2c0c7a75b253:/# salt '*' test.ping                                                                                                                                     
ed13fb6d5045:
    True
99350c48af7b:
    True
a68d9515ea90:
    True
8ba9b601aa1c:
    True
49cafd4611c9:
    True
3536c4ebd833:
    True
```

# Notes
* Internally, hosts resolve through their docker names, i.e. salt-master, controller01, compute01.
* Environment configured both over IPv4 and IPv6
* Images **fsoppelsa/saltmaster** and **fsoppelsa/saltminion** are pushed to the Hub, available to `docker pull`
* **fsoppelsa/saltmaster** has autobuild activated on the Hub

Enjoy 🍻
