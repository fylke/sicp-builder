# Known issues and risks

Things that are unverified, limited or likely to break. Not a to-do list; see
[PLAN.md](PLAN.md) for planned work.

## EPUB

- **Cover on an e-reader.** The fix (PNG in an `<img>` at full width) passes EPUBCheck and
  `check-epub.sh`, but has not been confirmed on a device.
- **Texinfo 6.0 is old.** The build patches 6.0 (`texinfo-sicp.patch`). 6.1 and later fail
  hunks of the patch, and 7.x needs a full port of upstream's `HTML.pm` changes.
- **Upstream is frozen** at `sarabander/sicp` commit `bda03f79` (`SICP_REF`). Upstream
  fixes will not arrive; the build depends on the repository staying available.
- **Fragile `sed` edits.** The Inkscape flags and the cover-page rewrite are done with
  checked `sed` commands in the Dockerfile. They fail the build if upstream text changes,
  but they would need updating then.
- **Pinned downloads** (Texinfo, Alegreya font, EPUBCheck) are checksummed. If a host
  removes a file or changes it, the build fails.
- **Fonts.** The cover needs Alegreya, Linux Libertine and Biolinum. If one is missing,
  Inkscape silently falls back to another font and no check notices, so look at the
  cover after any font change.
- **EPUB checks are heuristic.** The thresholds in `check-epub.sh` (39 chapter files,
  1300 `<math`, 10,000 code spans, cover of 100,000 bytes) are tuned to the current output.
  They catch gross breakage, not subtle rendering errors.
- **Math** is MathML produced by a Node port of the PhantomJS script. Reader support for
  MathML varies; only a few e-readers render it well.

## CI and releases

- CI for the latest commits has not been checked after the dev container and exercise
  changes.
- Releases are tagged `vYYYY.MM.DD-<short sha>` and are created on every push to `main`,
  including pushes that only change docs or exercises, so they may produce identical EPUBs.
- The weekly scheduled run and manual runs build but never publish.
- Base images use pinned Alpine tags, not digests, so rebuilds can still pick up changed
  packages.

## Dev container

- Not tested in VS Code or Codespaces; only the image contents and `exercises/example.rkt`
  were checked.
- `#lang sicp` does not define `stream-car` and `stream-cdr`; the sample defines them.
  The picture language is `(require sicp-pict)`.
- Racket 8.16 and the `sicp` package are not pinned beyond what the Debian trixie image
  provides.

## Exercises (Markdown)

- **Figures.** Only the ASCII art is kept (e.g. 2.42 and 3.73). Figures that are
  images, including Figure 3.37 for 3.80, are not included. A figure is appended to an
  exercise only when it sits in its own quotation right before the figure's anchor.
- **References.** `@ref` to anything other than an exercise becomes plain text, so
  "Figure 2.8" and section references are not links.
- **Math** is converted to `$…$` and `$$…$$` and has not been checked in a renderer.
  Plain-TeX constructs (`\matrix`, `\cr`, `\kern`, `\hline`) remain in 2.37 and 5.27 and
  may not render in KaTeX or MathJax. `eqnarray` blocks are rewritten to `aligned`.
- **Typography.** Quotes and dashes in prose are converted to Unicode and Markdown
  characters are escaped. Code is verbatim, but unusual text may be escaped
  wrongly.
- **Unsupported Texinfo** aborts the run, so a new upstream construct stops the build
  instead of producing bad output.
- **Exact count.** The script aborts unless it finds exactly 356 exercises.
- **Footnotes** are attached only to the exercise that cites them. The earlier text
  files wrongly attached some to other exercises.
- **No solutions or tests.** Only statements are provided, so there is no check that a
  solution is right.
- **Licence.** The text is the book's, under CC BY-SA 4.0. Derived files must keep that
  licence and attribution.

## Tests

- **Coverage.** 145 of 356 exercises have tests (chapter 1: 32, 2: 56, 3: 50, 4: 7,
  5: 0). The rest are listed with reasons in `tests/chapter-N/SKIPPED.md`: explanations,
  traces, timing, painters, concurrency, and anything that modifies the book's evaluator
  or register-machine simulator.
- **You choose the interface.** Where the exercise names no procedure, the test file's
  header comment states the names your solution must `#%provide`. Some names were chosen
  by the test author and may differ from what you'd pick.
- **Reference solutions were written alongside the tests**, by the same author, so a
  shared misreading of an exercise would not be caught. They live in `tests/reference/`
  and spoil the exercises.
- **Slow.** The full suite takes about 3 minutes against the references.
- **Timeouts.** Some chapter 1 tests wrap calls in a 10-second thread timeout so a
  looping wrong answer fails instead of hanging.
- **Weak spots.** 1.28 uses random trials, 3.8 relies on left-to-right argument
  evaluation, and 3.81 and 3.82 are checked by properties and tolerances.
- **`#lang sicp` quirks.** There is no `square` or `when`, and an internal `define` that
  uses an earlier internal `define` fails ("cannot use before initialization").
- **Book code you must supply.** The 2.67–2.70 tests need your file to define the book's
  Huffman tree code, and 3.80 assumes the book's `(RLC R L C dt)` interface.
- **CI** now runs the suite against the references; this has not run on GitHub yet.
