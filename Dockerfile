FROM node:18-bullseye-slim

RUN yarn global add @apollo/rover@v0.19.0

# Install CA certificates
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app


ENV APOLLO_ELV2_LICENSE=accept

COPY subgraphs/ /app/subgraphs/
COPY supergraph.graphql /app/supergraph.graphql
COPY supergraph.yaml /app/supergraph.yaml

# RUN rover supergraph compose --config supergraph.yaml --output xxxx.graphql

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./
RUN yarn install
COPY index.js /app/index.js

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]