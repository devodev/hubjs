'use strict';

// Imports
const express = require('express');
const http = require('http');
const winston = require('winston');

// Constants
const PORT = process.env.HUB_PORT || 8080;
const HOST = process.env.HUB_HOST || '0.0.0.0';

// Logging
const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  defaultMeta: { service: 'hub' },
  exitOnError: false,
  transports: [],
});
if (process.env.NODE_ENV === 'production') {
  logger
    .clear()
    .add(new winston.transports.File({ filename: 'error.log', level: 'error' }))
    .add(new winston.transports.File({ filename: 'combined.log' }));
} else {
  logger
    .clear()
    .add(new winston.transports.Console({
      timestamp: true,
      level: 'debug',
      handleExceptions: true,
      json: false,
      colorize: true
  }));
}

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Hello World\n');
});

// Server
http.createServer(app).listen(PORT, HOST, function (err) {
  if (err) {
    logger.error(err);
  } else {
    logger.info(`Listening on http://${HOST}:${PORT}`);
  }
});
