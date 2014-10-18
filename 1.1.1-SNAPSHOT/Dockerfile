FROM tifayuki/java:7

# Set default Grails Java Runtime env
ENV JAVA_OPTS -Xmx512m -XX:MaxPermSize=256m -Djetty.serverHost=0.0.0.0
ENV GRAILS_HOME /usr/local/grails
ENV PATH /usr/local/grails/bin:$PATH

# Install Grails
WORKDIR /usr/local
RUN wget -O - --quiet https://github.com/asans/appdist-archive/blob/master/grails/grails-1.1.1-SNAPSHOT-custom.tgz?raw=true | tar xzf -
# somehow contains some trace hidden files that causes our grails not to run properly
RUN ln -s /usr/local/grails-1.1.1-SNAPSHOT /usr/local/grails
RUN rm -f /usr/local/grails-1.1.1-SNAPSHOT/lib/._*

RUN mkdir /app
WORKDIR /app
