# Select a base image
FROM  node:21-alpine3.18 
LABEL version="v1"
LABEL description="Image for the frontend-dev"
ENV NODE_ENV=development
WORKDIR /frontend
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]