# Python 2.7.x

FROM python:2.7.16-buster
USER root

RUN apt-get update
RUN apt-get install -y vim less

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

# Install packages
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Jupyter (this part avoids crashes)
RUN mkdir src
WORKDIR /src/notebooks
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]


# $ docker-compose build
# $ docker-compose up
