# sicp-builder

A containerized builder for the [sicp](https://github.com/sarabander/sicp) project.
The image uses Ruby 3.4, Node.js and the distribution's Perl package. It retains
Texinfo 5.1, because the upstream converter depends on it.

Upstream's PhantomJS scripts are replaced by the Node ports in [scripts/](scripts):
LaTeX is converted to MathML with MathJax 3 (`mathjax-full`, no network access
needed) and Scheme code is highlighted with the bundled code-prettify run in jsdom.
The scripts keep their upstream file names, so the upstream `Makefile` is used as is.
The build regenerates all HTML (`make -B all`) and fails if any LaTeX could not be
converted. MathML attributes differ cosmetically from the committed upstream HTML
(MathJax 3 emits `data-mjx-texclass` where MathJax 2 emitted `class="MJX-TeXAtom-*"`).

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