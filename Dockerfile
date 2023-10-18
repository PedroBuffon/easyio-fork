FROM node:latest

ENV PUID=node
ENV PGID=node
ENV WEB_PORT=8080
ENV WEB_NAME=default

RUN mkdir -p /home/node/app/node_modules && chown -R ${PUID}:${PGID} /home/node/app

WORKDIR /home/node/app

COPY package*.json ./

USER root

RUN npm install express

COPY --chown=${PUID}:${PGID} . .

EXPOSE ${WEB_PORT}

USER $PUID

CMD node main.js --name ${WEB_NAME} --port ${WEB_PORT}