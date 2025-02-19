# Use Node.js 18 for frontend build
FROM node:18 AS frontend

# Set environment variables
ENV NPM_CONFIG_PRODUCTION=false

WORKDIR /frontend

# Copy package.json and install dependencies
COPY package*.json /frontend/
RUN npm install --legacy-peer-deps --ignore-scripts && npm run prepare || true

# Copy source files and build the project
COPY . /frontend
RUN npm run build

# Use Nginx to serve the built frontend
FROM nginx:latest
COPY --from=frontend /frontend/dist/ /usr/share/nginx/html
