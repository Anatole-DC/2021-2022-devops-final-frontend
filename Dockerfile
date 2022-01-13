FROM node:lts-fermium as development

WORKDIR /nest-server

COPY package*.json ./

RUN yarn install --only=development

COPY . .

RUN yarn run build

FROM node:lts-fermium as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /nest-server

COPY package*.json ./

RUN yarn install --only=production

COPY . .

COPY --from=development /nest-server/dist ./dist

CMD ["node", "dist/main"]