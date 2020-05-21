FROM node:14.2
ARG NPM_CONFIG_LOGLEVEL=info
ENV NPM_CONFIG_LOGLEVEL $NPM_CONFIG_LOGLEVEL

# Setup process wrapper
# This is needed for forwarding signals to node
ARG TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Setup server content and dependencies
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node package*.json ./
USER node
RUN npm ci --only=production
# This is an odd way of specifying alternate config file. Any better idea anyone? Please!
COPY --chown=node:node server.js ./
COPY --chown=node:node config ./config/

# Run server
USER node
ARG APP_PORT=8443
ARG APP_ADMIN_PORT=9876
EXPOSE ${APP_PORT} ${APP_ADMIN_PORT}
CMD [ "node", "server.js" ]
