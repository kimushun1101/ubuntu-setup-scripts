FROM ubuntu:latest

RUN apt-get update && apt-get install -y sudo git \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash sudo-user \
    && usermod -aG sudo sudo-user \
    && echo "sudo-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER sudo-user
WORKDIR /home/sudo-user
CMD ["/bin/bash"]
