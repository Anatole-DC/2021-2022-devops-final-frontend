# étape de build
FROM node:lts-fermium as build-stage
WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY . .
RUN yarn run build

# étape de production
FROM node:lts-fermium as production-stage
COPY --from=build-stage /app/dist ./dist
CMD ["node", "dist/main"]