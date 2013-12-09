var parser = require('./data');
var fs = require('fs');

fs.readFile('test.th', function (err, data) {
	if (err) throw err;
	console.log(JSON.stringify(parser.parse(data.toString()), null, 2));
});
