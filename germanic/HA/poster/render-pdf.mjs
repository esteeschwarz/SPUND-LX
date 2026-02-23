import { chromium } from 'playwright';

const browser = await chromium.launch();
const page = await browser.newPage();

await page.goto(`file://${process.cwd()}/001.html`, {
  waitUntil: 'networkidle'
});

await page.emulateMedia({ media: 'print' });

await page.pdf({
  path: 'poster_A0.pdf',
  width: '841mm',
  height: '1190mm',
  printBackground: true // background color of boxes!
});

await browser.close();