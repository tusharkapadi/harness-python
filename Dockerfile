FROM python:3.12-alpine

LABEL maintainer="Greg Taylor <gtaylor@gc-taylor.com>"

RUN pip install --upgrade pip setuptools wheel

COPY wheeldir /opt/app/wheeldir
COPY requirements.txt test-requirements.txt /opt/app/src/

RUN pip install --no-index --find-links=/opt/app/wheeldir \
    -r /opt/app/src/requirements.txt

RUN pip install --no-index --find-links=/opt/app/wheeldir \
    -r /opt/app/src/test-requirements.txt

COPY . /opt/app/src/
WORKDIR /opt/app/src
RUN python setup.py install

EXPOSE 5000
CMD ["dronedemo"]
