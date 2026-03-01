// import { chromium } from 'playwright';

// const browser = await chromium.launch();
// const page = await browser.newPage();

// await page.goto(`file://${process.cwd()}/001.html`, {
//   waitUntil: 'networkidle'
// });

// await page.emulateMedia({ media: 'print' });

// await page.pdf({
//   path: '../../../q/germanic/001/poster_A0.pdf',
//   width: '841mm',
//   height: '1190mm',
//   printBackground: true // background color of boxes!
// });

// await browser.close();



import { chromium } from 'playwright';
import os from 'os';
import fs from 'fs';
import path from 'path';

function findMacPlaywrightChromium() {
  const base =
    process.env.PLAYWRIGHT_BROWSERS_PATH ||
    path.join(os.homedir(), 'Library', 'Caches', 'ms-playwright');

  if (!fs.existsSync(base)) return null;

  const dirs = fs.readdirSync(base).filter(d => d.startsWith('chromium-'));

  if (!dirs.length) return null;

  // pick latest installed
  const latest = dirs.sort().reverse()[0];

  const chromePath = path.join(
    base,
    latest,
    'chrome-mac-x64',
    'Google Chrome for Testing.app',
    'Contents',
    'MacOS',
    'Google Chrome for Testing',
  );

  return fs.existsSync(chromePath) ? chromePath : null;
}

function resolveChromiumPath() {

  // 1️⃣ Explicit override
  if (process.env.CHROMIUM_PATH) {
    return process.env.CHROMIUM_PATH;
  }

  // 2️⃣ mac local Playwright cache
  if (os.platform() === 'darwin') {
    const pw = findMacPlaywrightChromium();
    if (pw) return pw;
  }

  // 3️⃣ Linux system chromium (CI / container)
  const linuxPaths = [
    '/usr/bin/chromium',
    '/usr/bin/chromium-browser',
    '/usr/bin/google-chrome',
    '/ms-playwright',
    '/ms-playwright/chromium-1208/chrome-linux64/chrome'

  ];

  for (const p of linuxPaths) {
    if (fs.existsSync(p)) return p;
  }

  throw new Error('No Chromium executable found.');
}

const browser = await chromium.launch({
  executablePath: resolveChromiumPath(),
  args: ['--no-sandbox', '--disable-setuid-sandbox']
});

const page = await browser.newPage();

await page.goto(`file://${process.cwd()}/001.html`);
await page.emulateMedia({ media: 'print' });

await page.pdf({
  path: '../../../q/germanic/001/poster_A0.pdf',
  width: '841mm',
  height: '1190mm',
  printBackground: true
});

await browser.close();