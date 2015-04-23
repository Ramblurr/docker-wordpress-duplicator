FROM tutum.co/casey/wordpress:latest
MAINTAINER Casey Link <casey@outskirtslabs.com>

WORKDIR /
RUN find /app  -mindepth 1 -maxdepth 1 ! -iname "wp-content" -exec rm -rf {} +

ADD run_duplicator.sh /run_duplicator.sh
RUN chmod +x /*.sh

VOLUME ["/duplicator"]

EXPOSE 80
CMD ["/run_duplicator.sh"]

