FROM debian:9

RUN apt-get update \
    && apt-get install -y \
        protobuf-compiler \
        python3-pil \
        python3-lxml \
        python3-pip \
        python3-dev \
        git \
    && pip3 install -U pip \
    && python3 -m pip install \
        Flask==1.1.1 \
        WTForms==2.2.1 \
        Flask_WTF==0.14.2 \
        Werkzeug==0.16.0 \
        tensorflow==2.0.0

WORKDIR /opt

RUN git clone https://github.com/tensorflow/models \
    && cd models/research \
    && protoc object_detection/protos/*.proto --python_out=.

COPY . /opt/

RUN chmod +x /opt/object_detection_app_p3/app.py

EXPOSE 80

CMD /opt/object_detection_app_p3/app.py
