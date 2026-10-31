#!/usr/bin/env node

// Usage: ./batch-prettify.js file1 [file2 ...]
// Node replacement for the PhantomJS script of the same name. Runs the
// bundled code-prettify over the Scheme code in the given XHTML files and
// removes the prettifier <script> elements afterwards.

const fs = require('fs');
const path = require('path');
const { JSDOM } = require('jsdom');

if (process.argv.length <= 2) {
  console.log('Usage: ./batch-prettify.js file1 [file2 ...]');
  process.exit(1);
}

const files = process.argv.slice(2).filter((file) => {
  if (fs.existsSync(file)) return true;
  console.log('No such file: ' + file);
  return false;
});

// The prettifier scripts are located relative to each page, as in the browser.
const readScript = (file, src) => fs.readFileSync(path.join(path.dirname(file), src), 'utf8');

function prettify(file) {
  const dom = new JSDOM(fs.readFileSync(file, 'utf8'), {
    contentType: 'application/xhtml+xml',
    runScripts: 'outside-only',
  });
  const { window } = dom;
  const { document } = window;

  const scripts = Array.from(document.getElementsByClassName('prettifier'));
  for (const script of scripts) window.eval(readScript(file, script.getAttribute('src')));

  return new Promise((resolve) => {
    window.prettyPrint(() => {
      scripts.forEach((script) => script.parentNode.removeChild(script));
      fs.writeFileSync(
        file,
        '<!DOCTYPE ' + document.doctype.name + '>\n' + document.documentElement.outerHTML
      );
      window.close();
      resolve();
    });
  });
}

(async () => {
  for (const file of files) await prettify(file);
})();
