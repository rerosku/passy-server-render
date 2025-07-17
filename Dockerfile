FROM node:20-alpine

WORKDIR /app

# Clona solo la cartella server
RUN apk add --no-cache git \
    && git clone --depth=1 --filter=blob:none --sparse https://github.com/glitterware/passy.git . \
    && git sparse-checkout init --cone \
    && git sparse-checkout set server

WORKDIR /app/server

RUN npm install --omit=dev

EXPOSE 3001

CMD ["node", "index.js"]
