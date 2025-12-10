FROM debian:latest

COPY init.sh /root/init.sh
COPY default.conf /root/default.conf
WORKDIR /root

CMD ["bash", "-c", "bash /root/init.sh /root/default.conf && exec zsh"]
