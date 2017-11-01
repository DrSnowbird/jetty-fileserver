# Jetty as Fileserver in a Docker Container

##Components:
Components:
* Oracle Java 8 JDK environment

## Pull the image from Docker Repository

```
docker pull openkbs/jetty-fileserver
```

## Build your own image from this

```
FROM openkbs/jetty-fileserver
```

## Copy your data folder under jetty_base
The default "run.sh" use the following base FTP directory. 

* Important: You need to copy your data folder "UNDER" the folder "jetty_base":

```
    $HOME/data-docker/jetty_fileserver/jetty_base/
```

Simply, you copy "source\_data\_folder" under the "jetty_base" folder:

```
    cp -r <source_data_filer> $HOME/data-docker/jetty_fileserver/jetty_base/
```

## Run the image

Then, you're ready to run:

```
docker run -d --name my-jetty-fileserver -i -t openkbs/jetty-fileserver
```

## Build and Run your own image
To build your own image, say, "my/jetty-fileserver".

```
docker build -t my/jetty-fileserver .
```

To run your own image with the name of "some-jetty-fileserver":

```
mkdir ./data
docker run -d --name some-jetty-fileserver -i -t my/jetty-fileserver
```

## Shell into the Docker instance

```
docker exec -it some-jetty-fileserver /bin/bash
```

