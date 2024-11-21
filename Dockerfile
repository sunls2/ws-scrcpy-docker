FROM node:lts-alpine AS deps
WORKDIR /app
RUN apk add --no-cache git gcompat python3 make g++ && npm install -g node-gyp
RUN git clone https://github.com/NetrisTV/ws-scrcpy.git . && npm i --omit=dev

FROM deps AS builder
WORKDIR /app
RUN npm i && npm run dist

FROM alpine AS runner
WORKDIR /app
RUN apk add --no-cache libstdc++ dumb-init android-tools \
    && addgroup -g 1000 node && adduser -u 1000 -G node -s /bin/sh -D node \
    && chown node:node ./
COPY --from=builder /usr/local/bin/node /usr/local/bin/
COPY --from=builder /usr/local/bin/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
USER node

COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

EXPOSE 8000
CMD dumb-init node ./dist/index.js
