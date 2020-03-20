FROM sm-base


RUN pip install tensorflow

RUN rm -rf /root/.cache