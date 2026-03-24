const puppeteer = require("puppeteer");

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.goto("file://" + __dirname + "/uwolf.html", {
    waitUntil: "networkidle0"
  });

  await page.pdf({
    path: "output.pdf",
    format: "A4",
    printBackground: true
  });

  await browser.close();
})();