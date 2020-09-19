# Base Image
#FROM centos:7
FROM amazonlinux:2018.03
CMD ["/bin/bash"]

# Maintainer
MAINTAINER Sermajid <sermajid@yahoo.com>

# Extra
LABEL version="3.4.11"
LABEL description="ProcessMaker 3.4.11 Docker Container - Apache & PHP 7.1"

# Initial steps
RUN yum clean all && yum install epel-release -y && yum update -y
RUN cp /etc/hosts ~/hosts.new && sed -i "/127.0.0.1/c\127.0.0.1 localhost localhost.localdomain `hostname`" ~/hosts.new && cp -f ~/hosts.new /etc/hosts
RUN yum install yum-utils -y

#RUN yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

#RUN yum-config-manager --enable remi-php71
RUN yum install \
  wget \
  nano \
  vim \
  sendmail \
  php71 \
  php71-opcache \
  php71-gd \
  php71-mysqlnd \
  php71-soap \
  php71-mbstring \
  php71-ldap \
  php71-mcrypt \
  -y
# Required packages
#RUN yum install \
#  wget \
#  nano \
#  vim \
#  sendmail \
#  php \
#  php-opcache \
#  php-gd \
#  php-mysqlnd \
#  php-soap \
#  php-mbstring \
#  php-ldap \
#  php-mcrypt \
#  httpd \
#  -y

# Download ProcessMaker Enterprise Edition
#RUN wget -O "/tmp/processmaker-3.3.0.tar.gz" \
#      "https://artifacts.processmaker.net/generic/processmaker-3.3.0-build4.tar.gz"

COPY processmaker-3.4.11-community.tar.gz /tmp/
# Copy configuration files
COPY pmos.conf /etc/httpd/conf.d
RUN mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bk
COPY httpd.conf /etc/httpd/conf

# Apache Ports
EXPOSE 80

# Docker entrypoint
COPY docker-entrypoint.sh /bin/
RUN chmod a+x /bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]