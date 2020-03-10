FROM python:3.7-slim


# Python won’t try to write .pyc or .pyo files on the import of source modules
# Force stdin, stdout and stderr to be totally unbuffered. Good for logging
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PYTHONIOENCODING=UTF-8 LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH="/opt/program:${PATH}"

RUN apt update # 17.4MB

RUN pip install flask # 26.8MB
RUN pip install boto3 # 84.2MB
RUN pip install pandas scikit-learn # 392MB
RUN pip install xgboost # 709MB
RUN pip install tensorflow # 717MB

# remove all the cache to save space 
RUN rm -rf /root/.cache # 533MB

ENV FLASK_ENV=production FLASK_APP=/opt/program/wsgi FLASK_RUN_HOST=0.0.0.0 FLASK_RUN_PORT=8080

COPY program/serve /opt/program/
WORKDIR /opt/program

RUN chmod +x /opt/program/serve