FROM codercom/code-server
USER root
ADD src /src/

RUN /src/install_packages.sh && /src/get-docker.sh && /src/install_pip_packages.sh && /src/git_config.sh
COPY ./src/.bashrc /root


WORKDIR /projects