# Specify the base image
FROM node:16

# Set the working directory for the app
WORKDIR /frontend/app

# Copy the package.json and package-lock.json files to the container
COPY ./Application/frontend/* ./

# Install the app's dependencies
RUN npm ci

# Expose the port the app will run on
EXPOSE 3000

# Start the app
CMD [ "npm", "start" ]