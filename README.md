docker-grails
=============

Grails in Docker Container.

Creates a docker container for specific grails versions.

## Stack

The docker build does the following:

* Uses Ubuntu Trusty (14.04.x)
* Uses Oracle JDK 7
* Grails via gvm

## Using the container

The environment is primarily used to launch a container that contains grails so you can either run grails inside the container for development, testing, and/or creating deployable WAR archives.

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
# in order versions of grails
docker run -i -t -p 8080:8080 --rm -v .:/app onesysadmin/grails:2.0 interactive
# in newer versions of grails, grails will run interactively when no args are given
docker run -i -t -p 8080:8080 --rm -v .:/app onesysadmin/grails:2.4
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
# If tests pass, let's create the war archive and build the deployment container
docker run -i -t -v .:/app onesysadmin/grails:latest war app.war
docker build -t myorg/myapp:1.1.1 .
# push out the docker container build to a repository
docker push myorg/myapp
```

A sample Dockerfile to build your grails web app would be something like the following:

```
# use a tomcat server container or your app specific container with tomcat optionally installed
FROM tutum/tomcat:8.0

ENV CATALINA_OPTS -Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -Xms512m -Xmx1300m -XX:PermSize=256m -XX:MaxPermSize=512m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC

EXPOSE 8080

# place app into tomcat app (alternatively, place it into ROOT for root webapp)
ADD app.war /tomcat/webapps
```

## CONTRIBUTING

Want to fix/enhance the codebase or add more grails versions to be repo?  

1. Fork this repository
2. Add your code changes
3. Submit a pull request to this repository

Once approved and merged, it will be added to Docker Hub to be built.
