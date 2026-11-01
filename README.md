# sicp-builder

A containerized builder for the [sicp](https://github.com/sarabander/sicp) project.
The image uses Ruby 3.4, Node.js and the distribution's Perl package. Upstream
targets Texinfo 5.1 with a modified `HTML.pm`; [texinfo-sicp.patch](texinfo-sicp.patch)
ports those modifications to Texinfo 6.0, which is built from the tarball. The HTML
it produces is identical to the 5.1 output apart from the generator comment.
Texinfo 7 is not an option: its converter was rewritten and would need a full port.

Upstream's PhantomJS scripts are replaced by the Node ports in [scripts/](scripts):
LaTeX is converted to MathML with MathJax 3 (`mathjax-full`, no network access
needed) and Scheme code is highlighted with the bundled code-prettify run in jsdom.
The scripts keep their upstream file names, so the upstream `Makefile` is used as is.
The build regenerates all HTML (`make -B all`) and fails if any LaTeX could not be
converted. MathML attributes differ cosmetically from the committed upstream HTML
(MathJax 3 emits `data-mjx-texclass` where MathJax 2 emitted `class="MJX-TeXAtom-*"`).

The cover thumbnail is rendered with Inkscape 1.x. The Dockerfile rewrites the
upstream `Makefile`'s removed `-e`/`-f` flags with a checked `sed`, and installs the
fonts the cover SVG uses: Linux Libertine/Biolinum from Alpine and a pinned,
checksummed Alegreya.

Base images (Alpine 3.24) and downloads (Texinfo, Alegreya, EPUBCheck) are pinned, and
downloads are verified by SHA-256.

Build the EPUB and write it to the current directory:

```sh
docker build --target epub --output type=local,dest=. .
```

This creates `sicp.epub`. The EPUB is validated with
[EPUBCheck](https://github.com/w3c/epubcheck) (pinned version and checksum, warnings
treated as failures) and by [check-epub.sh](check-epub.sh) (chapter count, MathML,
highlighted code, cover size, no missing figures) before it is exported, so a build
that produces an invalid EPUB fails instead of writing the file. The final image stage contains only the EPUB; the
toolchain lives in the intermediate `build` stage. To build a different upstream
revision, add `--build-arg SICP_REF=<commit>`.

To inspect the build environment, build and run the `build` stage:

```sh
docker build --target build -t sicp-builder .
docker run --rm -it sicp-builder bash
```
## Dev container for the exercises

Open the repository in VS Code and choose "Reopen in Container" (or use any
devcontainer-compatible tool). [.devcontainer/](.devcontainer) provides:

- Racket with the `sicp` language: start a file with `#lang sicp` to get `cons-stream`,
  `inc`/`dec`, `nil`, `amb` and the rest of what the book assumes. The picture language
  (section 2.2.4) is `(require sicp-pict)`.
- MIT Scheme (`mit-scheme`), the dialect the book was written for.
- The Magic Racket VS Code extension.

Each of the 356 exercises is a Racket file in [exercises/](exercises), for example
`exercises/chapter-1/exercise-1.09.rkt`. The problem statement is a comment at the top
(Markdown, readable as is), followed by the test command and the names the test expects.
Write your solution below it in the same file, starting with the
`(#%provide ...)` line the header asks for. `racket exercises/example.rkt` runs a sample.
The text is the book's, under
[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), extracted from the Texinfo
source. Regenerating the files would overwrite your solutions, so write them to a scratch
directory and copy over only the missing ones:

```sh
docker build --target exercises --output type=local,dest=/tmp/exercises .
cp -rn /tmp/exercises/. exercises/
```
 The dev container is separate from the EPUB build and does not affect it.

### Checking your answers

Tests live in [tests/](tests), one file per testable exercise
(`tests/chapter-1/exercise-1.03.test.rkt`). The header of each exercise file (copied from
its test) lists the names your solution must provide, for example:

```racket
#lang sicp
(#%provide sum-of-squares-of-two-largest)
(define (square x) (* x x))
(define (sum-of-squares-of-two-largest a b c) ...)
```

Put that in `exercises/chapter-1/exercise-1.03.rkt`, below the statement, then run, inside
the dev container:

```sh
raco test tests/chapter-1/exercise-1.03.test.rkt   # one exercise
raco test tests/chapter-1                          # one chapter
raco test tests                                    # everything
```

Until you write a solution its tests fail ("does not provide ..."), so `raco test tests`
shows what is left. Exercises that can't be checked automatically (explanations, traces,
timing, or changes to the book's big evaluator and machine simulator) have no test; each
chapter's `SKIPPED.md` (e.g. [tests/chapter-1/SKIPPED.md](tests/chapter-1/SKIPPED.md))
lists them and says why.

The tests are checked against reference solutions in `tests/reference/`. Don't read
those if you want to work the exercises yourself. To run the suite against them:

```sh
SICP_SOLUTIONS=$PWD/tests/reference raco test tests
```


## CI

[.github/workflows/build.yml](.github/workflows/build.yml) builds and validates the EPUB
on pushes to `main`, pull requests, weekly and on manual dispatch, and uploads it as the
`sicp-epub` artifact. Each push to `main` also publishes a
[release](../../releases) with the EPUB, tagged `vYYYY.MM.DD-<short sha>`; pull requests,
the weekly run and manual runs only verify the build.

Remaining ideas are tracked in [PLAN.md](PLAN.md).
