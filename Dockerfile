# Node version matching the version declared in the package.json 
FROM node:16-slim

# Update O.S.
RUN apt-get update && apt-get upgrade -y 

# Install required O.S. packages
RUN apt-get install -y git python make g++

# Create the application workdir
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app

# Set current user
USER node

# Copy app dependencies
COPY package*.json ./

# Install app dependencies
RUN yarn

# Bundle app source
COPY --chown=node:node . .

# Compile TypeScript
RUN yarn build

# Set the container port 
EXPOSE 3000

# Start the aplication
CMD ["yarn", "run", "start" ]
