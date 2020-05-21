FROM node:14.2
ENV NPM_CONFIG_LOGLEVEL info

# Setup server content and dependencies
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node package*.json ./
USER node
RUN npm ci --only=production
COPY --chown=node:node . .

# Setup process wrapper
# This is needed for forwarding signals to node
USER root
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Run server
USER node
EXPOSE ${PORT}
CMD [ "node", "server.js" ]
