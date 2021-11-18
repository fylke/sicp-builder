# sicp-builder
A self-contained builder for the [sicp](https://github.com/sarabander/sicp) project.


Build the image with `docker build -t <image_name> .`

Start the container with `docker run --name <container_name> <image_name>`

Attach to a shell inside the container `docker -i -t <container_name> /bin/bash`

Build, run and attach to the shell, all in one command: `docker run -it $(docker build .) bash`