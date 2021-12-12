# Docker workshops part 2
------
## Goals
- Build a docker image
- Teach what are the common issues in the docker and how to avoid them
- Build a docker-compose
- Show common issues and how to handle them
- Show a couple of useful shell aliases
------
## Rules
- Tell me if I need to repeat something or when I am going to fast
- Ask questions
------
## Let's make a Dockerfile
- FROM
- RUN
- COPY
- ADD
- WORKDIR
- EXPOSE
- ENV
- CMD
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
- If it makes sens use multi-staged builds
- Don't run docker image as a root unless needed
- Rebuild images with `--pull` `--no-cache` from time to time to get security updates
- use image scanners (docker scan/trivy)
------
## Docker-compose
------
### Let's build a docker-compose file
------
### Adding env variables to docker-compose
------
#### Environment option
```
version: '3'
services:
  db:
    image: mysql:latest
    environment:
      - MYSQL_DATABASE: 'db'
      - MYSQL_USER: 'user'
      - MYSQL_PASSWORD: 'password'
      - MYSQL_ROOT_PASSWORD # resolved to their values on the machine Compose is running on
```
------
#### env-file option
```
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
- Compose file
- Shell environment variables
- Environment file (bottom to top)
- Dockerfile
- Variable is not defined
------
```
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
