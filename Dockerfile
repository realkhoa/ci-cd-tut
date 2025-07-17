FROM oven/bun:latest as build-stage
WORKDIR /app    
COPY . .
RUN bun install --frozen-lockfile
RUN bun run build

FROM nginx:latest as production-stage
WORKDIR /app
COPY --from=build-stage /app/dist /usr/share/www
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx-conf/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80