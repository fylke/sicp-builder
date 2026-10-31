#!/usr/bin/env node

// Usage: ./get-math.js json_db file1 [file2 ...]
// Node replacement for the PhantomJS script of the same name. Extracts LaTeX
// delimited by \( \) or \[ \] from the given files, converts it to MathML with
// MathJax 3 and stores the LaTeX -> MathML mapping in json_db. Entries already
// present in json_db are reused.

const fs = require('fs');
const { mathjax } = require('mathjax-full/js/mathjax.js');
const { TeX } = require('mathjax-full/js/input/tex.js');
require('mathjax-full/js/input/tex/base/BaseConfiguration.js');
require('mathjax-full/js/input/tex/ams/AmsConfiguration.js');
require('mathjax-full/js/input/tex/newcommand/NewcommandConfiguration.js');
const { liteAdaptor } = require('mathjax-full/js/adaptors/liteAdaptor.js');
const { RegisterHTMLHandler } = require('mathjax-full/js/handlers/html.js');
const { STATE } = require('mathjax-full/js/core/MathItem.js');
const { SerializedMmlVisitor } = require('mathjax-full/js/core/MmlTree/SerializedMmlVisitor.js');
const { translate } = require('mathjax-full/js/util/Entities.js');

const pattern = /\\\([\s\S]+?\\\)|\\\[[\s\S]+?\\\]/g;

if (process.argv.length <= 3) {
  console.log('Usage: ./get-math.js json_db file1 [file2 ...]');
  process.exit(1);
}

const db = process.argv[2];
const files = process.argv.slice(3);

const latexSet = new Set();
for (const file of files) {
  const text = fs.readFileSync(file, 'utf8');
  for (const match of text.matchAll(pattern)) latexSet.add(match[0]);
}

const known = fs.existsSync(db) ? JSON.parse(fs.readFileSync(db, 'utf8')) : {};
const result = {};
const todo = [];
for (const latex of latexSet) {
  if (known[latex]) result[latex] = known[latex];
  else todo.push(latex);
}

if (todo.length > 0) {
  RegisterHTMLHandler(liteAdaptor());
  const html = mathjax.document('', { InputJax: new TeX({ packages: ['base', 'ams', 'newcommand'] }) });
  const visitor = new SerializedMmlVisitor();
  let faulty = 0;

  for (const latex of todo) {
    const display = latex.startsWith('\\[');
    // The delimiters are two characters on each side. Entities such as &lt;
    // are decoded, as a browser would have done for the original script.
    const tex = translate(latex.slice(2, -2));
    const mml = visitor.visitTree(html.convert(tex, { display, end: STATE.CONVERT }), html);
    if (/<merror\b/.test(mml)) {
      faulty++;
      console.error('Faulty LaTeX: ' + latex);
      result[latex] = "<span class='faulty'>" + latex + '</span>';
    } else {
      result[latex] = mml;
    }
  }
  if (faulty > 0) console.error(faulty + ' LaTeX fragment(s) could not be converted.');
}

fs.writeFileSync(db, JSON.stringify(result, null, 2));
