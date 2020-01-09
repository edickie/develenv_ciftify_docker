FROM poldracklab/fmriprep:1.3.2

# pull in userargs for github username..
ARG GITHUBUSER
ARG GITHUBNAME
ARG GITHUBEMAIL

RUN conda install jupyterlab \
    nose

RUN mkdir /opt/msm && \
    curl -sSL https://github.com/ecr05/MSM_HOCR_macOSX/releases/download/1.0/msm_ubuntu > /opt/msm/msm && \
    chmod 755 /opt/msm/msm

ENV PATH=/opt/msm:$PATH

RUN apt-get update && apt-get install -y connectome-workbench=1.3.2-2~nd16.04+1

RUN mkdir /home/${GITHUBUSER}/code && \
    git clone https://github.com/${GITHUBUSER}/ciftify.git /home/${GITHUBUSER}/ciftify; \
    cd /home/${GITHUBUSER}/ciftify; \
    git config --global user.name ${GITHUBNAME}; \
    git config --global user.email ${GITHUBEMAIL}; \

ENV PATH=/home/${GITHUBUSER}/ciftify/ciftify/bin:${PATH} \
    PYTHONPATH=/home/${GITHUBUSER}/ciftify:${PYTHONPATH} \
    CIFTIFY_TEMPLATES=/home/${GITHUBUSER}/ciftify/ciftify/data

WORKDIR /tmp/

RUN mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \"0.0.0.0\" > ~/.jupyter/jupyter_notebook_config.py

ENTRYPOINT ["/bin/bash"]
