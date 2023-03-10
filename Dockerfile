FROM quay.io/kubespray/kubespray:v2.21.0

RUN sed -i \
    -e 's|https://github.com|{{ github_com_mirror }}|g' \
    -e 's|https://storage.googleapis.com|{{storage_googleapis_com_mirror}}|g' \
    roles/download/defaults/main.yml

COPY ansible-playbook/* .

RUN chmod +x entorypint.sh

ENTRYPOINT ["./entorypint.sh"]

CMD ["--version"]