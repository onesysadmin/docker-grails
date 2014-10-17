docker-grails
=============

Grails in Docker Container.

Creates a docker container for specific grails versions.

## Stack

The docker build does the following:

* Uses Ubuntu 14.04 (Trusty)
* Uses Oracle JDK 7
* Uses Tomcat 8
* Grails via gvm

## Using the container

The environment is primarily used to launch a container that contains grails so you can either run grails inside the container for development, testing, and/or creating deployable WAR archives.  You can even use it to deploy a Grails app as Tomcat 8 is included by default.

### Versions

Different containers have been created for different grails versions.  Here's a sample list of versions that are built:

* latest - usually updated to correspond to the latest grails version release
* x.x - uses the newest minor version for the major version specified

Grails major versions tags such as 2.1 and 2.2 uses the newest version for that branch.  So, for example, grails:2.1 will use 2.1.5

### Launching Grails

The container is set to run like an app via the use of ENTRYPOINT.  That means you can do something like the following:

```
docker run -i -t -p 8080:8080 --rm -v .:/app onesysadmin/grails:2.4 run-app
```

This allows you to run grails like it has been installed on your host OS without actually installing all the developer tools on your OS. Cool!

Want to run grails interactively so you can issue multiple commands without having to keep launching new runtime containers and recompiling and reinstalling plugins every single time?

```
docker run -i -t -p 8080:8080 --rm -v .:/app onesysadmin/grails:2.4 interactive
```

Want a bash shell into the container so you can do some setups instead of launching grails by default? Override the entry point:

```
# override entrypoint
docker run -i -t -p 8080:8080 --rm -v .:/app --entrypoint bash onesysadmin/grails:2.4
```

If you map the project directory into the container, you can development under your host IDE and grails will detect those changes and reload

### Testing and Continuous Integration

For continuous integration or to run your tests under a CI server like Jenkins, you can create a Jenkins project that is capable of launching docker instances.  You can then create a Dockerfile that Jenkins can use to test or deploy your app container.  Your build/test script might look something like the following:

```
#!/bin/bash

# test the app first to see if it passes
# create app-specific container beforehand if additional dependencies are required
# use your own container to run the tests if that's the case
docker run -i -t -v .:/app onesysadmin/grails:latest test-app
# If tests pass, let's create the full app container
docker build -t myorg/myapp:1.1.1 .
# push out the docker container build to a repository
docker push myorg/myapp
```

A sample Dockerfile to build your grails web app would be something like the following:

```
# use a tomcat server container or your app specific container with tomcat optionally installed
FROM onesysadmin/grails:2.4

ENV CATALINA_OPTS -Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -Xms512m -Xmx1300m -XX:PermSize=256m -XX:MaxPermSize=512m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC

EXPOSE 8080

# launch tomcat instance by default instead of grails
ENTRYPOINT ["/app/run-app.sh"]

ADD <app files> /src
WORKDIR /src
RUN grails war app.war
# place app into tomcat app (alternatively, place it into ROOT for root webapp)
RUN mv app.war /tomcat/webapps
```

## Building Your Own Version-Specific Grails Container

Creating your version-specific grails container allows you to use any grails version you like along with installing any other supporting frameworks or libraries that your app requires.

A base grails container has been built and is set under `onesysadmin/grails:base`.  By using this base container as your parent, you can just use gvm to install the version you need.  Better yet, submit a pull request and have it included into this repository to be shared with others.

## CONTRIBUTING

Want to fix/enhance the codebase or add more grails versions to be built?  

1. Fork this repository
2. Add your code changes
3. Submit a pull request to this repository

Once approved and merged, it will be added to Docker Hub to be built.
