FROM quay.io/kubespray/kubespray:v2.21.0

RUN apt-get update && apt-get install -y rsync
COPY docker-init.sh .
RUN sh docker-init.sh

COPY ansible-playbook/* .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

CMD ["--version"]