# Plan

Done so far: Ruby 3.4 on Alpine 3.24, Node ports of the PhantomJS scripts, EPUB-only
multi-stage build gated by EPUBCheck, proper cover fonts, Texinfo 6.0 via
`texinfo-sicp.patch`, checksummed downloads, GitHub Actions build.

## Remaining

1. **Check the CI workflow.** `.github/workflows/build.yml` has not run on GitHub yet.
   Confirm the first run passes and the `sicp-epub` artifact is uploaded.
2. **Pin the validate stage.** `eclipse-temurin:21-jre-alpine` is unpinned; pin a tag
   or digest.
3. **Tidy the Dockerfile.**
   - Drop `gcompat` (was for PhantomJS) if the build still passes without it.
   - Replace the `ln -s /usr/local/bin/ruby /usr/bin/ruby` hack with a shebang-safe fix.
   - Merge the separate `wget`/`tar` steps and clean up build-only packages.
4. **Stronger EPUB checks.** EPUBCheck only validates structure. Add content checks
   (expected chapter count, MathML present, cover image non-trivial, no missing
   fonts in the cover render).
5. **Texinfo 7 (large, optional).** The patch no longer applies cleanly to 6.1+, and
   7.x rewrote the converter (703 `.html` files instead of 42 `.xhtml`, and it
   drops `@setshortcontentsaftertitlepage`). It needs a full port of upstream's
   `HTML.pm` customizations through the Texinfo 7 customization API, diffing
   against the current output until the EPUB matches.
6. **Upstream contributions (optional).** Upstream `sarabander/sicp` is dormant, but
   PRs for the Inkscape 1.x flags and the PhantomJS replacement are possible.

## Notes

- `docker` here is podman: use fully qualified `docker.io/library/...` image names.
- Export only the EPUB: `docker build --target epub --output type=local,dest=. .`
- The SSH remote is not authorised; push over HTTPS with the `gh` credential helper.
