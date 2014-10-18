FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["grails"]

# install newest version of grails 1.3.x
RUN gvm-wrapper.sh install grails 1.3.9 && gvm-wrapper.sh flush archives
