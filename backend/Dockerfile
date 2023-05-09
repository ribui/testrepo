# THIS IS THE BACKEND DOCKERFILE

# Specify the base image
FROM node:16-alpine

# Set the working directory for the app
WORKDIR /app

COPY package*.json ./

# Copy the package.json and package-lock.json files to the container
RUN npm install

COPY . .
RUN npm ci

# Expose the port the app will run on
EXPOSE 8080

# Start the app
CMD [ "npm", "start" ]
