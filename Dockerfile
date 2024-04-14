FROM node:12.22.1-alpine as build-stage
WORKDIR /app

ENV VUE_APP_URL_BACKEND=''
COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.17.10-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]

# para crear la imagen ejecute
#sudo docker build -t mirepo/ejemplofrontend:latest .