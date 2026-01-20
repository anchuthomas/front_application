FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:alpine

# 1. Copy the build output
COPY --from=build /app/dist/ecommerce_frontend /usr/share/nginx/html 

# 2. ADD THIS LINE: Copy your custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
