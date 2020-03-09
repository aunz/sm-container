FROM python:3.7-slim


# Python won’t try to write .pyc or .pyo files on the import of source modules
# Force stdin, stdout and stderr to be totally unbuffered. Good for logging
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PYTHONIOENCODING=UTF-8 LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH="/opt/program:${PATH}"

RUN apt update
RUN apt install -y --no-install-recommends nginx

RUN pip install flask gevent gunicorn boto3
RUN pip install pandas scikit-learn
RUN pip install xgboost
RUN pip install tensorflow

# remove all the cache to save space 
RUN rm -rf /root/.cache

COPY program /opt/program
WORKDIR /opt/program