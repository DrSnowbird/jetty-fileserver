# Jetty as Fileserver in a Docker Container

# Components:
* Jetty version: 9.4.14.v20181114
* java version "1.8.0_191"
  Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
  Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
* Apache Maven 3.6.0
* Python 3.5.2
* npm 3.5.2 + nodejs v4.2.6
* Gradle 5.1

# Run (recommended for easy-start)
Image is pulling from openkbs/mongodb-compass
```
./run.sh
```

## Prepare your Web Folder
The default "run.sh" use the following base FTP directory.
* Important: You need to copy your data file into the folder "UNDER" the folder "jetty_base":

```
    $HOME/data-docker/jetty_fileserver/jetty_base/

~/data-docker/jetty-fileserver: 
.
├── data
├── jetty_base
└── workspace

```

## Web File URL Access
For production, you need to configure Jetty to support https to be secured transport.
```
http://<host_ip>:18080/jetty_base/ (if remotely access the Jetty FTP server)
or
http://localhost:18080/jetty_base/ (if you are on the same local host)
```


# Pull the image from Docker Repository

```
docker pull openkbs/jetty-fileserver
```

# Build your own image from this

```
FROM openkbs/jetty-fileserver
```

# Build and Run your own image
To build your own image, say, "my/jetty-fileserver".

```
docker build -t my/jetty-fileserver .
```

To run your own image with the name of "some-jetty-fileserver":

```
mkdir ./data
docker run -d --name some-jetty-fileserver -i -t my/jetty-fileserver
```

# Shell into the Docker instance
You can simply run ./shell.sh
or

```
docker exec -it some-jetty-fileserver /bin/bash
```
