FROM node:18-alpine as build-stage

WORKDIR /app
COPY package*.json ./
RUN apk update && apk add --no-cache git
RUN npm install
COPY . .
RUN npm run build_no_type_check

FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
