#!/bin/sh
# Content checks that EPUBCheck does not cover. Usage: check-epub.sh book.epub
set -eu

epub=$1
dir=$(mktemp -d)
unzip -q "$epub" -d "$dir"
cd "$dir/html"

fail() { echo "CONTENT CHECK FAILED: $*" >&2; exit 1; }

chapters=$(ls ./*.xhtml | wc -l)
[ "$chapters" -ge 39 ] || fail "expected at least 39 chapter files, found $chapters"

math=$(cat ./*.xhtml | grep -o '<math' | wc -l)
[ "$math" -ge 1300 ] || fail "expected at least 1300 MathML elements, found $math"

# A cover rendered without the right fonts is much smaller than the real one (~175 KB).
cover=$(wc -c < fig/cover.png)
[ "$cover" -ge 100000 ] || fail "cover.png is only $cover bytes; fonts missing?"

# Failed math conversion and syntax highlighting leave these markers behind.
! grep -lE "color:blue|class='faulty'|\\\\\(" ./*.xhtml || fail "unconverted math or error markers found"

highlighted=$(cat ./*.xhtml | grep -o '<span class="pln"' | wc -l)
[ "$highlighted" -ge 10000 ] || fail "expected highlighted code, found $highlighted spans"

# Every embedded figure must exist in the package.
missing=0
for ref in $(grep -oh '\(data\|src\)="[^"#:]*\.\(svg\|png\|jpg\)"' ./*.xhtml | sed 's/^[a-z]*="//; s/"$//' | sort -u); do
  [ -f "$ref" ] || { echo "missing: $ref" >&2; missing=1; }
done
[ "$missing" -eq 0 ] || fail "referenced figures are missing"

rm -rf "$dir"
echo "Content checks passed: $chapters files, $math math, $highlighted code spans, cover $cover bytes."
