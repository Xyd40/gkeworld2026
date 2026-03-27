FROM nginx:alpine
RUN echo "<h1>Welcome to GKEMaster 2026</h1><p>Running on Autopilot in us-central1</p>" > /usr/share/nginx/html/index.html
