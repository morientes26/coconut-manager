# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:14 as build


WORKDIR /usr/src/app 

COPY . /usr/src/app/ 


# Install all the dependencies
RUN npm install

RUN npm run build


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:latest

# # Copy the build output to replace the default nginx contents.
COPY --from=build /usr/src/app/dist/* /usr/share/nginx/html

COPY --from=build /usr/src/app/docker/default.conf /etc/nginx/conf.d/default.conf
# # Expose port 80
EXPOSE 8080
