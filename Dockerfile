FROM tomcat:7.0.91-jre7
RUN apt-get update \
    && apt-get install -y git wget unzip dpkg

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get install -y esl-erlang=1:19.3.6
RUN apt-get install -y elixir=1.6.6-2
RUN wget https://amazonadsi-a.akamaihd.net/public/Amazon-Mobile-App-SDK-by-Platform/Amazon-Android-SDKs.zip
RUN unzip Amazon-Android-SDKs.zip
RUN mv `find ./Amazon-Android-SDKs -name RVSSandbox.war` /usr/local/tomcat/webapps/
