# Layer1 : builder
FROM node:22 as builder

WORKDIR /app

COPY package*json ./

RUN npm install

COPY . .

RUN npm run build

# Layer2 : server
FROM nginx:1.26-alpine

WORKDIR /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/build /app

EXPOSE 80