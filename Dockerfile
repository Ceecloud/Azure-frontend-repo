# FROM node:18-alpine



# COPY . .

# RUN npm install --save-dev @babel/plugin-proposal-private-property-in-object
# RUN npm install --save react react-dom @types/react @types/react-dom
# RUN npm install react-scripts@3.0.1  --save
# RUN npm install

# # Attempt to fix vulnerabilities, but continue if it fails
# RUN npm audit fix --force || echo "Continuing despite npm audit fix failures"

# EXPOSE 3000

# CMD ["npm", "start"]



# ---------- BUILD STAGE ----------
# FROM node:18-alpine AS build

# WORKDIR /app

# COPY package*.json ./
# RUN npm install

# COPY . .
# RUN npm run build


# # ---------- RUN STAGE ----------
# FROM nginx:alpine

# # Remove default nginx static files
# RUN rm -rf /usr/share/nginx/html/*

# # Copy React build output
# COPY --from=build /app/build /usr/share/nginx/html

# # Expose HTTP
# EXPOSE 80

# # Start nginx
# CMD ["nginx", "-g", "daemon off;"]


# ---------- Build stage ----------
# FROM node:18-alpine AS build
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build

# # ---------- Runtime stage ----------
# FROM nginx:alpine
# COPY --from=build /app/build /usr/share/nginx/html

# # React router fix
# RUN rm /etc/nginx/conf.d/default.conf
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

FROM node:18-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# React router support
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]




