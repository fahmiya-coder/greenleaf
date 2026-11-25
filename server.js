const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 8080;
const DIR = path.join(__dirname, 'build', 'web');

const MIME_TYPES = {
  '.html': 'text/html',
  '.js': 'text/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.woff': 'application/font-woff',
  '.ttf': 'application/font-ttf',
  '.otf': 'application/font-otf',
  '.wasm': 'application/wasm'
};

const server = http.createServer((req, res) => {
  let safePath = req.url.split('?')[0];
  let filePath = path.join(DIR, safePath);

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      filePath = path.join(DIR, 'index.html');
    }
    const ext = String(path.extname(filePath)).toLowerCase();
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    fs.readFile(filePath, (readErr, content) => {
      if (readErr) {
        res.writeHead(500);
        res.end('Error loading file');
      } else {
        res.writeHead(200, {
          'Content-Type': contentType,
          'Access-Control-Allow-Origin': '*'
        });
        res.end(content, 'utf-8');
      }
    });
  });
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`greenleaf server running at http://localhost:${PORT}/`);
});
