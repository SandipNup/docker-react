#here we are going to build the multi-step docker file for production grade
#here we are going to have to images one to build the 'build' directory and another to start the nginx server

#here we are taking the node:alpine image and defining this phase with the name 'builder' 
#By defing 'as builder' in 'FROM' command which means from this FROM command and Underneath it 
#going to be builder phase.The soul purpose of this phase is to install dependencies and build 
#our application 
FROM node:alpine as builder   

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
#create the build directory 
RUN npm run build 

#defining the another from defines the end of the previous phase which is builder 
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

#what this copy line saying is whe are going to copy from different phase called builder and we are going
#to copy 'build' folder from '/app/build' to '/usr/share/nginx/html' 

#the default command of nginx will start the container so we need not have to define the container
#when we copy the 'build' folder from the previous phase everything from that phase is dropped off
