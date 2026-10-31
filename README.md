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

Build the EPUB and write it to the current directory:

```sh
docker build --target epub --output type=local,dest=. .
```

This creates `sicp.epub`. The EPUB is validated with
[EPUBCheck](https://github.com/w3c/epubcheck) (pinned version and checksum, warnings
treated as failures) before it is exported, so a build that produces an invalid EPUB
fails instead of writing the file. The final image stage contains only the EPUB; the
toolchain lives in the intermediate `build` stage. To build a different upstream
revision, add `--build-arg SICP_REF=<commit>`.

To inspect the build environment, build and run the `build` stage:

```sh
docker build --target build -t sicp-builder .
docker run --rm -it sicp-builder bash
```