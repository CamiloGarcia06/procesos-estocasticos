FROM python:3.11-slim

# Avoids Python buffering logs
ENV PYTHONUNBUFFERED=1
# Prevents creation of .pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Install system dependencies for common data science libraries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        wget \
        curl \
        ca-certificates \
        liblapack-dev \
        libopenblas-dev \
        pkg-config \
        libfreetype6-dev \
        libpng-dev \
        libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
        jupyterlab \
        notebook \
        pandas \
        numpy \
        scipy \
        scikit-learn \
        statsmodels \
        seaborn \
        matplotlib \
        plotly \
        sympy \
        ipywidgets

# Create a non-root user to run Jupyter
ARG NB_USER=datauser
ARG NB_UID=1000
ENV USER=${NB_USER}
ENV NB_UID=${NB_UID}
ENV HOME=/home/${NB_USER}

RUN useradd -m -s /bin/bash -N -u ${NB_UID} ${NB_USER}

RUN mkdir -p /workspace && chown ${NB_UID}:${NB_UID} /workspace

WORKDIR /workspace

USER ${NB_USER}

# Expose Jupyter default port
EXPOSE 8888

# Start JupyterLab by default; can be overridden with `docker run ... <cmd>`
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=", "--NotebookApp.password="]
