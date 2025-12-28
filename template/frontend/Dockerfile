FROM node:24.12.0-alpine3.23 AS builder

# Accept DOMAIN as build argument
ARG DOMAIN
ENV DOMAIN=$DOMAIN

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Copy source and build
COPY . .
RUN npx astro telemetry disable
RUN npm run build

# Output stage - just copy dist to volume
FROM alpine:3.23
WORKDIR /dist
COPY --from=builder /app/dist ./
CMD ["sleep", "infinity"]
