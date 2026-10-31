#!/usr/bin/env node

// Usage: ./put-math.js json_db file1 [file2 ...]
// Node replacement for the PhantomJS script of the same name. Replaces LaTeX
// delimited by \( \) or \[ \] in the given files with the MathML stored in
// json_db. LaTeX without a mapping is painted blue.

const fs = require('fs');

const pattern = /\\\([\s\S]+?\\\)|\\\[[\s\S]+?\\\]/g;

if (process.argv.length <= 3) {
  console.log('Usage: ./put-math.js json_db file1 [file2 ...]');
  process.exit(1);
}

const mathml = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));

for (const file of process.argv.slice(3)) {
  const text = fs.readFileSync(file, 'utf8');
  const replaced = text.replace(
    pattern,
    (latex) => mathml[latex] || "<span style='color:blue'>" + latex + '</span>'
  );
  fs.writeFileSync(file, replaced);
}
