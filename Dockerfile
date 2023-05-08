# Specify the base image
FROM node:16-alpine
# FROM node:16

# Set the working directory for the app
WORKDIR /app

COPY ./frontend/package*.json ./
# Copy the package.json and package-lock.json files to the container
RUN npm install
COPY ./frontend .

# Install the app's dependencies
# RUN npm ci

# Expose the port the app will run on
EXPOSE 3000

# Start the app
CMD [ "npm", "start" ]
