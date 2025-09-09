# --- Build stage (Node, tiny) ---
FROM node:20-alpine AS build
WORKDIR /app
ENV NODE_ENV=production
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build  # outputs to /app/dist

# --- Run stage (Nginx, tiny) ---
FROM nginx:alpine
# Optional: remove default config and add ours
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy static build
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
HEALTHCHECK CMD wget -qO- http://localhost/ || exit 1
CMD ["nginx", "-g", "daemon off;"]
