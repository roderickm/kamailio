# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xfb40d3e6508ea4c8
RUN echo "deb http://deb.kamailio.org/kamailio trusty main" >> etc/apt/sources.list
RUN echo "deb-src http://deb.kamailio.org/kamailio trusty main" >> etc/apt/sources.list
RUN apt-get update -qq \
 && apt-get install --no-install-recommends --no-install-suggests -qqy \
        inotify-tools \
        kamailio \
        kamailio-outbound-modules \
        kamailio-sctp-modules \
        kamailio-tls-modules \
        kamailio-utils-modules \
        kamailio-websocket-modules \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN  mkdir /etc/service/kamailio
COPY kamailio_runit.sh /etc/service/kamailio/run
COPY dispatcher_watch.sh /
COPY kamailio.cfg /etc/kamailio/kamailio.cfg
COPY dispatcher.list /etc/kamailio/dispatcher.list
EXPOSE 5060
