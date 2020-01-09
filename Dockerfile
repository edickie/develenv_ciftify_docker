FROM poldracklab/fmriprep:1.3.2

RUN conda install jupyterlab \
    nose

RUN mkdir /opt/msm && \
    curl -sSL https://github.com/ecr05/MSM_HOCR_macOSX/releases/download/1.0/msm_ubuntu > /opt/msm/msm && \
    chmod 777 /opt/msm/msm

ENV PATH=/opt/msm:$PATH

RUN apt-get update && apt-get install -y connectome-workbench=1.3.2-2~nd16.04+1

RUN mkdir /home/code && \
    git clone https://github.com/edickie/ciftify.git /home/code/ciftify

ENV PATH=/home/code/ciftify/ciftify/bin:${PATH} \
    PYTHONPATH=/home/code/ciftify:${PYTHONPATH} \
    CIFTIFY_TEMPLATES=/home/code/ciftify/ciftify/data

WORKDIR /tmp/

RUN mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \"0.0.0.0\" > ~/.jupyter/jupyter_notebook_config.py

ENTRYPOINT ["/bin/bash"]
