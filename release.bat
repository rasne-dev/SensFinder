@echo off
setlocal
set "RELEASE_DIR=%~dp0"
set "RELEASE_TARGET=%~1"
node --input-type=commonjs -e "const fs=require('fs'),s=fs.readFileSync(process.argv[1],'utf8'),i=s.lastIndexOf('/*__NODE_START__*/');if(i<0)throw new Error('Marker not found');new Function('require','process','__dirname',s.slice(i))(require,process,process.env.RELEASE_DIR);" "%~f0"
exit /b %errorlevel%

/*__NODE_START__*/
'use strict';

const fs = require('fs');
const path = require('path');
const vm = require('vm');

function nextDecimalVersion(ver) {
  const parts = String(ver).trim().split('.').map(Number);
  if (parts.length !== 3 || parts.some(n => !Number.isInteger(n) || n < 0)) {
    throw new Error(`Invalid version format: "${ver}"`);
  }
  let [major, minor, patch] = parts;
  patch += 1;
  if (patch > 9) {
    patch = 0;
    minor += 1;
    if (minor > 9) {
      minor = 0;
      major += 1;
    }
  }
  return `${major}.${minor}.${patch}`;
}

function validateInlineScripts(html) {
  const scriptRe = /<script(?![^>]*\bsrc=)[^>]*>([\s\S]*?)<\/script>/gi;
  let match;
  let count = 0;
  let totalLines = 0;
  while ((match = scriptRe.exec(html)) !== null) {
    count += 1;
    const code = match[1];
    totalLines += code.split(/\r?\n/).length;
    new vm.Script(code, { filename: `index.html#script-${count}` });
  }
  if (count === 0) {
    throw new Error('No inline <script> block found in index.html');
  }
  return { count, totalLines };
}

function main() {
  const rootDir = __dirname || process.cwd();
  const indexPath = path.join(rootDir, 'index.html');
  const readmePath = path.join(rootDir, 'README.md');

  if (!fs.existsSync(indexPath)) throw new Error('index.html not found');
  if (!fs.existsSync(readmePath)) throw new Error('README.md not found');

  const rawArg = (process.env.RELEASE_TARGET || '').trim();
  if (rawArg === '--help' || rawArg === '-h') {
    console.log('Usage: release.bat [X.Y.Z]');
    console.log('Without arguments, increments index.html version using 0-9 decimal rollover.');
    return;
  }

  let html = fs.readFileSync(indexPath, 'utf8');
  let readme = fs.readFileSync(readmePath, 'utf8');

  const metaRe = /(<meta\s+name="version"\s+content=")(\d+\.\d+\.\d+)("\s*>)/;
  const metaMatch = html.match(metaRe);
  if (!metaMatch) {
    throw new Error('Could not find <meta name="version" content="X.Y.Z"> in index.html');
  }

  const currentVer = metaMatch[2];
  const nextVer = rawArg ? rawArg.replace(/^v/i, '') : nextDecimalVersion(currentVer);
  if (!/^\d+\.\d+\.\d+$/.test(nextVer)) {
    throw new Error(`Invalid target version "${nextVer}". Expected X.Y.Z`);
  }

  let updatedHtml = html.replace(metaRe, `$1${nextVer}$3`);

  const fallbackRe = /(version:document\.querySelector\('meta\[name="version"\]'\)\?\.content\|\|')(\d+\.\d+\.\d+)(')/;
  if (!fallbackRe.test(updatedHtml)) {
    throw new Error('Could not find exportDataJSON version fallback in index.html');
  }
  updatedHtml = updatedHtml.replace(fallbackRe, `$1${nextVer}$3`);

  const badgeRe = /(\[!\[Version\]\(https:\/\/img\.shields\.io\/badge\/version-)(\d+\.\d+\.\d+)(-e8ff47)/;
  if (!badgeRe.test(readme)) {
    throw new Error('Could not find Version badge in README.md');
  }
  const updatedReadme = readme.replace(badgeRe, `$1${nextVer}$3`);

  const { count, totalLines } = validateInlineScripts(updatedHtml);

  fs.writeFileSync(indexPath, updatedHtml, 'utf8');
  fs.writeFileSync(readmePath, updatedReadme, 'utf8');

  console.log(`[SensFinder Release] ${currentVer} -> ${nextVer}`);
  console.log(`[OK] Synchronized version across index.html and README.md`);
  console.log(`[OK] Validated ${count} inline script(s) (${totalLines} lines)`);
  console.log(`[OK] Single-file artifact ready: ${indexPath}`);
  console.log(`RELEASE READY: v${nextVer}`);
}

try {
  main();
} catch (err) {
  console.error(`[ERROR] ${err && err.message ? err.message : err}`);
  process.exit(1);
}
