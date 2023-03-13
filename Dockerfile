FROM quay.io/kubespray/kubespray:v2.21.0

RUN apt-get update && apt-get install -y rsync
RUN cp inventory/mycluster/group_vars/all/offline.yml inventory/sample/group_vars/all/mirror.yml; \
    sed -i -E '/# .*\{\{ files_repo/s/^# //g' inventory/sample/group_vars/all/mirror.yml; \
    tee -a inventory/sample/group_vars/all/mirror.yml <<EOF
gcr_image_repo: "gcr.m.daocloud.io"
kube_image_repo: "k8s.m.daocloud.io"
docker_image_repo: "docker.m.daocloud.io"
quay_image_repo: "quay.m.daocloud.io"
github_image_repo: "ghcr.m.daocloud.io"
files_repo: "https://files.m.daocloud.io"
EOF

COPY ansible-playbook/* .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

CMD ["--version"]