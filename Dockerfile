FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y; apt-get upgrade -y
RUN apt-get install -y curl software-properties-common
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get update -y
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java8-installer

ADD ./scripts/start.sh /start.sh
RUN chmod +x /start.sh
VOLUME ["/data"]
CMD ["/start.sh"]
