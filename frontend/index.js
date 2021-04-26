const express = require('express');
const app = express();
const port = 3333;


app.use(express.static(__dirname + '/static'));

app.get('/', (req, res) => {
    res.redirect('/login');
});

app.get('/profile', (req, res) => {
    res.sendFile('./static/Child.html', { root: __dirname });
});

app.get('/login', (req, res) => {
    res.sendFile('./static/Login.html', { root: __dirname });
});




app.listen(port, () => console.log(`listening on port ${port}!`));