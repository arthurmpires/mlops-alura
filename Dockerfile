FROM python:3.9.13-slim

ARG BASIC_AUTH_USERNAME_ARG
ARG BASIC_AUTH_PASSWORD_ARG

ENV BASIC_AUTH_USERNAME=$BASIC_AUTH_USERNAME_ARG
ENV BASIC_AUTH_PASSWORD=$BASIC_AUTH_PASSWORD_ARG

COPY ./requirements.txt /user/requirements.txt
WORKDIR /user
RUN pip3 install -r requirements.txt

COPY ./src /user/src/
COPY ./models /user/models

ENTRYPOINT [ "python3" ]
CMD [ "src/app/main.py" ]
# the two lines above are similar to running "python3 src/app/main.py" on a terminal

# to create the docker container (image), run the line below on a terminal:
# docker build -t ml-api --build-arg BASIC_AUTH_USERNAME_ARG=Arthur --build-arg BASIC_AUTH_PASSWORD_ARG=Lexy .

# to run the docker container, run the line below on a terminal:
# docker run -p 8080:8080 ml-api

# to run the docker container on google cloud:


# other docker commands:
# to print all containers # docker ps -a 
# to remove a container # docker rm {container_id}
# to print all images # docker images
# to remove a image # docker rmi {image_name}
# to build a container with basic authentication # docker build -t ml-api --platform linux/amd64 --build-arg BASIC_AUTH_USERNAME_ARG=Arthur --build-arg BASIC_AUTH_PASSWORD_ARG=Lexy .
# (line of code above must be called from inside the working directory where the Dockerfile is located)
# (the --platform linux/amd64 tag is specific for Mac, because the container image must be compiled for Linux)
# create a google cloud tag # docker tag ml-api gcr.io/global-brook-378510/ml-api
# push the image to google cloud # docker push gcr.io/global-brook-378510/ml-api 