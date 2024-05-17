const express = require("express");
const puppeteer = require("puppeteer");
const cors = require("cors");
const app = express();

// app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

app.get("/lol", async (req, res) => {
  res.send("lolkek");
});

app.post("/create-pdf", async (req, res) => {
  const htmlContent = req.body.html;

  try {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();

    await page.setContent(htmlContent, { waitUntil: "networkidle0" });

    const pdfBuffer = await page.pdf({
      format: "A4",
      printBackground: true,
      margin: {
        top: "30px",
        right: "30px",
        bottom: "30px",
        left: "30px",
      },
    });

    await browser.close();

    res.setHeader("Content-Type", "application/pdf");
    res.setHeader("Content-Length", pdfBuffer.length);
    res.send(pdfBuffer);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error generating PDF");
  }
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
