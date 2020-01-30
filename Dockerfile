# Using official python runtime base image
FROM python:2.7-alpine

# Set the application directory
WORKDIR /app

# Install our requirements.txt
ADD requirements.txt /app/requirements.txt
#ENV https_proxy=http://192.168.140.250:80
#ENV http_proxy=http://192.168.140.250:80
#ENV no_proxy="atlassian-bitbucket.idahive.sg,dkregistry.idahive.sg,dkreg-pvt-e.idahive.sg,localhost,127.0.0.1,*.app.idahive.sg,*.api.idahive.sg,*.idahive.sg,kubernetes.default.svc,.kubernetes.default.svc,*.kubernetes.default.svc,172.30.0.1"
ENV FLASK_APP="/app/app.py"
RUN easy_install `cat requirements.txt`

# Copy our code from the current folder to /app inside the container
ADD . /app

RUN chown -Rf root:root /app
RUN chmod -Rf g+rwx /app

# Make port 80 available for links and/or publish
EXPOSE 5000

# Define our command to be run when launching the container
CMD flask run --host=0.0.0.0
