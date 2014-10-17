docker-grails
=============

Grails in Docker Container.

Creates a docker container for specific grails versions.

## Stack

The docker build does the following:

* Uses Ubuntu 14.04 (Trusty)
* Uses Oracle JDK 7
* Uses Tomcat 8
* Installs Grails installed in `/usr/local/grails-<version>`
* Creates a link from /usr/local/grails/ to the versioned grails
* Sets certain environment variables

## Using the container

The environment is primarily used to launch a container that contains grails so you can either run grails inside the container for development, testing, and creating deployable WAR archives.

### Development

To run the container for development, you will need to map the grails dev port and your project directory into the container like the following:

`docker run -i -t -p 8080:8080 -v <project root>:/app bash`

Once you are in the instance, you can then do something like the following:

```
cd /app
grails run-app
```

If you map the project directory into the container, you can development under your host IDE and the docker container will detect those changes and reload

### Testing and Continuous Integration

For continuous integration or to run your tests under a CI server like Jenkins, you can create a Jenkins project that is capable of launching docker instances.  You can then create a Dockerfile that Jenkins can use to your app container.  Your build/test script might look something like the following:

```
#!/bin/bash


# test the app first to see if it passes
# create app-specific container beforehand if additional dependencies are required
# use your own container to run the tests if that's the case
docker run -i -t -v <project dir>:/app -w /app onesysadmin/grails:<optional grails version> grails test-app
# If tests pass, let's create the full app container
docker build -t <app name>:<version> .
# push out the docker container build to a repository
docker push <app name>
```

A sample Dockerfile to build your grails web app would be something like the following:

```
# use a tomcat server container or your app specific container with tomcat optionally installed
FROM onesysadmin/grails:<version>

ENV CATALINA_OPTS -Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -Xms512m -Xmx1300m -XX:PermSize=256m -XX:MaxPermSize=512m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC

EXPOSE 8080

# launch script by default
CMD ["/app/run-app.sh"]

ADD <app files> /src
WORKDIR /src
RUN grails war app.war
# place app into tomcat app (alternatively, place it into ROOT for root webapp)
RUN mv app.war /tomcat/webapps
```

