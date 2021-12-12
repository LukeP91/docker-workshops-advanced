## Docker workshops II
## The Cache Strikes Back
------
## Goals
- Build a docker image
- Teach what are the common issues in the docker and how to avoid them
- Build a docker-compose
- Explain some inner workings of docker and docker-compose
------
## Rules
- Tell me if I need to repeat something or when I am going to fast
- Ask questions
------
## Let's make a Dockerfile
------
### FROM
- sets the base image and initializes a new build stage
- must be first instruction in the dockerfile (Except for ARG)
------
### RUN
- will execute any commands in a new layer on top of the current image and commit the results
- cache for `RUN` instructions isn’t invalidated automatically during the next build
------
### COPY
- copies files/folders from source to container
- creates a layer
- invalidates cache if file content has changed
------
### ADD
- copies files/folders from source to container
- creates a layer
- invalidates cache if file content has changed
- unpacks archives
------
### WORKDIR
- sets the working directory for subsequent commands
- will create the directory if it doesn't exists
- can be used multiple times
------
### EXPOSE
- informs that container listnes on a given port
- does not publish the port (use `-p` flag to publish on map port when running the conatainer)
- acts as a documentation
------
### ENV
- sets env variable for all the subsequent instructions during build time
- persists when the container is run
------
### CMD
- There can only be one CMD instruction in a Dockerfile
- provide defaults for an executing container
- does not run at build time
------
## Docker caching
- used to speed up build time
- cache is invalidated if command changed or file content changed
- when adding commands try to have the least changing things at the top
- RUN, COPY, ADD, FROM create layers, the rest of commands makes intermediate layers
------
## Common issues with Dockerfiles with examples
------
## Other points for docker
------
### When should you push images to docker repository
- when you want to publish something in official repo or share it between projects
- use private repo for project related docker images
- push images to registry when you deploy using docker
- use fe. commit sha as docker tag, so you know which revision you run on prod and can easily rollback
- DO NOT USE LATEST TAG IN PRODUCTION
------
### Security
- Use trusted base images (Official images/Verified Partners)
- Most often than not smaller base image and less libraries is safer
- Don't set envs that have security credentials in Dockerfile. They can be seen in docker history
- If it makes sense use multi-staged builds
- Don't run docker image as a root unless needed
- Rebuild images with `--pull` and `--no-cache` from time to time to get security updates
- use image scanners (docker scan/trivy)
------
## Docker-compose
------
### Let's build a docker-compose file
------
### Adding env variables to docker-compose
------
#### Environment option
```docker-compose
version: '3'
services:
  db:
    image: mysql:latest
    environment:
      - MYSQL_DATABASE: 'db'
      - MYSQL_USER: 'user'
      - MYSQL_PASSWORD: 'password'
# resolved to their value on the machine Compose is running on
      - MYSQL_ROOT_PASSWORD
```
------
#### env-file option
```docker-compose
version: '3'
services:
  db:
    image: mysql:latest
    env_file:
      - .env.development
      - .env.development.local
```
------
#### Order of env lookup
1. Compose file
2. Shell environment variables
3. Environment file (bottom to top)
4. Dockerfile
5. Variable is not defined
------
```docker-compose
version: '3'
services:
  db:
    image: mysql:latest
    env_file:
      - .env.development
      - .env.development.local
    environment:
      - MYSQL_DATABASE: 'db'
      - MYSQL_USER: 'user'
      - MYSQL_PASSWORD: 'password'
      - MYSQL_ROOT_PASSWORD
```
------
## Resources
- https://docs.docker.com/
- https://pythonspeed.com/docker/
- https://github.com/hadolint/hadolint
------
# Thanks
