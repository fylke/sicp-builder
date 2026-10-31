# sicp-builder

A containerized builder for the [sicp](https://github.com/sarabander/sicp) project.
The image uses Ruby 3.4 and the distribution's Perl package. It retains Texinfo 5.1
and PhantomJS 2.1.1 because the upstream converter and scripts depend on them. The
image packages the upstream project's checked-in HTML into an EPUB. Regenerating that
HTML still needs a migration away from PhantomJS and the retired MathJax CDN.

Build the image with `docker build -t sicp-builder .`. By default, it fetches the
upstream revision pinned in the Dockerfile and builds the EPUB during image creation.
To build a different upstream revision, pass `--build-arg SICP_REF=<commit>`.

Start an interactive container with `docker run --rm -it sicp-builder /bin/bash`.
The generated EPUB is at `/sicp.epub` in the image.

To keep a container running and attach a shell later:

```sh
docker run -d --name sicp-builder sicp-builder
docker exec -it sicp-builder /bin/bash
docker rm -f sicp-builder
```