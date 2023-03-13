FROM quay.io/kubespray/kubespray:v2.21.0

RUN apt update && apt install -y --no-install-recommends \
    curl python3 python3-pip sshpass vim rsync openssh-client \
    && rm -rf /var/lib/apt/lists/* /var/log/* \
    && pip install --no-cache-dir \
    ansible==5.7.1 \
    ansible-core==2.12.5 \
    cryptography==3.4.8 \
    jinja2==2.11.3 \
    netaddr==0.7.19 \
    jmespath==1.0.1 \
    MarkupSafe==1.1.1 \
    ruamel.yaml==0.17.21

COPY docker-init.sh .
RUN sh docker-init.sh

COPY ansible-playbook/* .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

CMD ["--version"]