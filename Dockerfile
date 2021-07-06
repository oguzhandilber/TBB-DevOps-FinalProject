FROM python:3.6-slim

RUN apt-get clean \
    && apt-get -y update

RUN apt-get -y install \
    nginx \
    python3-dev \
    build-essential

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt --src /usr/local/src

COPY . .

ENV MYSQL_USERNAME="root"
ENV db_root_password="123456"
ENV db_name="flaskapi"
ENV MYSQL_SERVICE_HOST="mysql"
ENV MYSQL_SERVICE_PORT=3306

EXPOSE 5000
CMD [ "python", "flaskapi.py" ]
