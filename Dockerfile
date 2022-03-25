FROM node:latest as build-stage


WORKDIR /app

COPY . .
RUN npm install
#在容器内build
RUN npm run build

# production stage
# 最后通过nginx部署build出来的文件(/dist)
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
