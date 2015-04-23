FROM tutum.co/casey/wordpress:latest
MAINTAINER Casey Link <casey@outskirtslabs.com>

WORKDIR /
RUN rm -rf /app && \
    mkdir /app

ADD run_duplicator.sh /run_duplicator.sh
RUN chmod +x /*.sh

VOLUME ["/duplicator"]

EXPOSE 80
CMD ["/run_duplicator.sh"]

