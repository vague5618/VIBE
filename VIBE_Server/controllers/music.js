var musicDTO = require('../models/DTO/musicDTO');
var musicDAO = require('../models/DAO/musicDAO');
var spawn = require('child_process').spawn;

module.exports.create = function(req, res) {
    musicDAO.createMusic(req,res);
};

module.exports.read = function(req, res) {
    musicDAO.readMusic(req,res); 
};

module.exports.update = function(req, res) {
    musicDAO.updateMusic(req,res); 
};

module.exports.delete= function(req, res) {
    musicDAO.deleteMusic(req,res); 
};

module.exports.start = function(req, res) {

    musicDAO.outMusic(req,res);
};

module.exports.check = function(req, res) {

    var array = req.body.array;

    console.log("length : " + array.length);

    var process = spawn('python',["./python/NN.py", array]);
    var result="";

    process.stderr.on('data', function(data) {
    });

    process.stdout.on('data', function(data) {

        result = data.toString();
        console.log(data.toString());
        res.send(result);
    });

};

module.exports.makeData = function(req, res) {

    var array = req.body.array;

    console.log("connectin : "+connection);
    console.log("length : " + array.length);

    var file = fs.createWriteStream('./number9_'+connection+'.txt');
    file.on('error', function(err) { /* error handling */ });

    array.forEach(function(i, idx, array){
        if (idx === array.length - 1){
            file.write(i);
        }
        else {
            file.write(i + ",");
        }
    });
    file.end();

    connection++;

    res.send("ok");

};