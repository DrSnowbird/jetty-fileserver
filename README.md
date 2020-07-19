# Jetty 9 + Java 8 OpenJDK + Maven 3.6 + Python 3.6 + pip 20.0 + node 14 + npm 6 + Gradle 8 

[![](https://images.microbadger.com/badges/image/openkbs/jetty-fileserver.svg)](https://microbadger.com/images/openkbs/jetty-fileserver "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/jetty-fileserver.svg)](https://microbadger.com/images/openkbs/jetty-fileserver "Get your own version badge on microbadger.com")

# Components:
* Jetty version: 9.4.30.v20200611
* Base Components (e.g., Maven, Java, NodeJS, etc.)
  * See [openkbs/jdk-mvn-py3 - Components](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md#Components)
  * See [openkbs/jdk-mvn-py3 - Releases Information](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md#Releases-information)

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
http://<host_ip>:18080/jetty_base/ (if you remotely access the Jetty FTP server)
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
