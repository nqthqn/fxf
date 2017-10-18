const http = require('http');
const fs = require('fs');

const hostname = '127.0.0.1';
const port = 3000;

const person = JSON.parse(fs.readFileSync('person.json', 'utf8'));
const cake = JSON.parse(fs.readFileSync('cake.json', 'utf8'));

const server = http.createServer((req, res) => {
  res.statusCode = 200; // nothing will ever go wrong!
  res.setHeader('Content-Type', 'application/json');
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if(req.url==='/cake'){
    res.end(JSON.stringify(cake));
  }
  else if (req.url==='/person'){
    res.end(JSON.stringify(person));
  }
  else if(/cake\/\d*/.test(req.url)){
    const id = parseInt(req.url.split('/')[2], 10);
    const c = cake.filter(c => c.id==id)[0]
    res.end(JSON.stringify(c));
  }
  else if(/person\/\d*/.test(req.url)){
    const id = parseInt(req.url.split('/')[2], 10);
    const c = person.filter(c => c.id==id)[0]
    res.end(JSON.stringify(c));
  }
});


server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});