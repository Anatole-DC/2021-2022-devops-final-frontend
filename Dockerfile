# étape de build
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY . .
RUN yarn run build

# étape de production
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist ./dist
CMD ["nginx", "-g", "daemon off;"]