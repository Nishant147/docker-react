FROM node:17.6-alpine as build_stage
USER node
WORKDIR /app
COPY --chown=node:node ./package.json ./
RUN ["npm", "install"]
COPY --chown=node:node . .
RUN [ "npm", "run", "build"]

FROM nginx:1.21-alpine
COPY --from=build_stage /app/build /usr/share/nginx/html
EXPOSE 80