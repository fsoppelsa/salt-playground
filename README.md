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
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS                              NAMES
d701748ad010        saltplayground_master         "/root/start.sh 6"       3 seconds ago       Up 1 seconds        0.0.0.0:4505-4506->4505-4506/tcp   salt-master
86c4952225b9        saltplayground_controller03   "/root/wait-for-minio"   7 seconds ago       Up 3 seconds                                           controller03
0dc145d30062        saltplayground_web01          "/root/wait-for-minio"   7 seconds ago       Up 3 seconds                                           web01
e919680db69b        saltplayground_controller01   "/root/wait-for-minio"   7 seconds ago       Up 3 seconds                                           controller01
03b4df88e265        saltplayground_compute02      "/root/wait-for-minio"   7 seconds ago       Up 3 seconds                                           compute02
3bdddea4d118        saltplayground_compute01      "/root/wait-for-minio"   7 seconds ago       Up 3 seconds                                           compute01
ff8cc3bf89f4        saltplayground_controller02   "/root/wait-for-minio"   7 seconds ago       Up 3 seconds                                           controller02
```

Then attach to the master with bash:

```
$ docker exec -ti salt-master bash
root@salt-master:/# salt-key -F
Local Keys:
master.pem:  65:07:a1:a1:de:3c:44:59:c8:7a:15:f3:43:c0:4c:1c:90:b3:87:14:bb:c0:18:9c:c1:7b:b1:57:f4:87:cc:7e
master.pub:  6b:02:4c:44:c9:a6:c1:a1:83:86:a7:cc:32:9d:2a:54:ef:02:8e:c3:1d:8c:41:30:54:cb:43:ce:f6:6a:01:d5
Accepted Keys:
cmp01:  d1:0f:f4:19:a0:ad:34:99:67:fd:1a:0d:54:da:9f:84:d6:18:55:b8:13:3b:04:51:6c:ff:39:5f:07:d6:74:30
cmp02:  a2:7e:1c:c2:50:70:71:61:66:31:0b:c4:e0:6c:9b:d1:55:fa:f6:16:00:7f:33:31:ad:14:6f:31:61:6d:15:97
ctl01:  14:95:7b:1f:68:54:6e:a0:c7:75:b8:9e:b6:e8:64:2a:da:f8:c3:7a:a8:b3:38:5f:73:be:be:ec:d7:6f:4d:f6
ctl02:  31:40:6e:b3:65:52:a4:e2:b1:7e:e6:bf:8e:f6:1f:08:1b:cd:77:81:13:15:69:16:e5:6a:a8:f2:6c:45:9c:d4
ctl03:  a4:0b:be:72:0b:14:d5:9a:ac:81:4a:9f:69:5f:0a:93:dc:8c:44:ee:b6:8d:65:05:33:47:2e:99:01:f2:fe:fd
web01:  19:2e:a8:8c:2e:8b:c2:e0:97:9d:25:cf:06:3b:de:0c:46:1b:68:c8:6a:4e:e8:12:38:72:df:1b:40:16:14:52
root@salt-master:/# salt '*'
web01:
    True
cmp01:
    True
cmp02:
    True
ctl01:
    True
ctl02:
    True
ctl03:
    True
```

# Notes
* Internally, hosts resolve through their docker names, i.e. salt-master, controller01, compute01.
* Environment configured both over IPv4 and IPv6
* Images **fsoppelsa/saltmaster** and **fsoppelsa/saltminion** are pushed to the Hub, available to `docker pull`
* **fsoppelsa/saltmaster** has autobuild activated on the Hub

Enjoy 🍻
