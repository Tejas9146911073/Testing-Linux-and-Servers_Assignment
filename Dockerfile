FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y tzdata cron sudo htop sysstat libpam-pwquality vim tar && \
    apt-get clean
COPY *.sh /root/
RUN chmod +x /root/*.sh
WORKDIR /root/
CMD ["/bin/bash", "-c", "/root/run_all.sh"]
