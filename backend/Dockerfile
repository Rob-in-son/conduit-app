# Select a base image
FROM  node:21-alpine3.18
LABEL version="v1"
LABEL description="Image for the backend-dev"
ENV NODE_ENV=development
WORKDIR /backend
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3001
CMD ["npm", "run", "dev"]