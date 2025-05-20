# Etapa de build
FROM node:18-alpine as build

ENV N8N_EDITION=community

WORKDIR /app
COPY . .

RUN npm ci && npm run build

# Etapa de produção
FROM node:18-alpine

ENV N8N_EDITION=community
ENV N8N_PORT=5678

WORKDIR /app
COPY --from=build /app .

RUN npm ci --omit=dev

EXPOSE 5678

CMD ["npx", "n8n"]