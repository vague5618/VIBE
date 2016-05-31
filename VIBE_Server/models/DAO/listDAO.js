var mongoose = require('mongoose');
var listDTO = require('../DTO/listDTO');
var musicDTO = require('../DTO/musicDTO');

module.exports = {};

module.exports.createList = function(req, res) {
	var newList = new listDTO();
	newList._id = new mongoose.Types.ObjectId;
	newList.musicArray = push("musicname");
	newList.addedBy = req.body.username;
    newList.save();
};

module.exports.readList = function(req, res) {
	listDTO.find({ _id: req.body.id }, function (err, result) {
		if(err) return err;
		console.log("[!] Id : "+req.body.id);
		res.writeHead(200, {"Content-Type": "application/json"});
	    res.end(JSON.stringify(result));
	    console.log("[!] List : \n"+result+"\n");
	});
};

module.exports.updateList = function(req, res) {
	listDTO.findById(req.body.id, function (err, list) {
	  if (err) return handleError(err);
	  list.musicArray = push("musicname");
	  list.save(function (err) {
	    if (err) return handleError(err);
	    res.send(list);
	  });
	});
};

module.exports.deleteList = function(req, res) {
	listDTO.remove({ _id : req.body.id }, function(err,removed) {
		if (err) return handleError(err);	
		res.writeHead(200, {"Content-Type": "application/json"});
	    res.end(JSON.stringify(result));
	});
};

/*
module.exports.temp1 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("HklEKtIQ");
		newList.musicArray.push("S1ZlVKYIm");
		newList.musicArray.push("BJzxNFYU7");
		newList.musicArray.push("rJVeVYtUm");
		newList.musicArray.push("SyxeNFY87");
		newList.musicArray.push("S1UlEFYU7");
		newList.musicArray.push("rkvl4KKIm");
		newList.musicArray.push("SyQe4YY87");
		newList.musicArray.push("SySxVtKI7");
		newList.musicArray.push("BkulNtY87");
		newList.addedBy = "admin";
	    newList.save();
	    res.end();
};

module.exports.temp2 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("rkcEtYI7");
		newList.musicArray.push("Hkl94YYI7");
		newList.musicArray.push("ryZ9EFKU7");
		newList.musicArray.push("Bkz5EKtUm");
		newList.musicArray.push("rkmcVKY8m");
		newList.musicArray.push("HJEcEtFLm");
		newList.musicArray.push("SkB9NYF8m");
		newList.musicArray.push("HkI5NYKUQ");
		newList.musicArray.push("B1vqVttIX");
		newList.musicArray.push("Syuq4ttIX");
		newList.musicArray.push("HkKcEtFL7");
		newList.musicArray.push("H1qcNYtUQ");
		newList.addedBy = "admin";
	    newList.save();
};

module.exports.temp3 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("B14SKY87");
		newList.musicArray.push("SyeEHKYUQ");
		newList.musicArray.push("SybErtKUQ");
		newList.musicArray.push("H1GEBKFIm");
		newList.musicArray.push("SJQ4HKKUm");
		newList.musicArray.push("SyNEHtKUm");
		newList.musicArray.push("ByBVSKtIX");
		newList.musicArray.push("SkU4rtKIm");
		newList.musicArray.push("HyvEHtFIQ");
		newList.addedBy = "admin";
	    newList.save();
};

module.exports.temp4 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("ry9SFYLm");
		newList.musicArray.push("SJgqSFFUm");
		newList.musicArray.push("B1W9BYFU7");
		newList.musicArray.push("B1MqrKKU7");
		newList.musicArray.push("H1mcSFKUQ");
		newList.musicArray.push("B1EcBttL7");
		newList.musicArray.push("HkSqSYKLX");
		newList.musicArray.push("SyLqrKtUm");
		newList.musicArray.push("BJwcrKF8X");
		newList.addedBy = "admin";
	    newList.save();
};

module.exports.temp5 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("HywLKFLQ");
		newList.musicArray.push("HJeDIFKL7");
		newList.musicArray.push("rJWvIKFIQ");
		newList.musicArray.push("ByzPIFYLX");
		newList.musicArray.push("B1mP8KKL7");
		newList.musicArray.push("r14v8tFUQ");
		newList.addedBy = "admin";
	    newList.save();
};


module.exports.temp6 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("H1lDYYIX");
		newList.musicArray.push("r1egwKKIQ");
		newList.musicArray.push("HkbewKK8X");
		newList.musicArray.push("BkzlDKFLQ");
		newList.musicArray.push("HkmlvKtIX");
		newList.musicArray.push("SJEeDKKI7");
		newList.musicArray.push("B1BgwtFIX");
		newList.addedBy = "admin";
	    newList.save();
};
module.exports.temp7 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("HkhvYtLQ");
		newList.musicArray.push("SJxhDKFL7");
		newList.musicArray.push("B1b2wYYL7");
		newList.musicArray.push("BJGhwKtIQ");
		newList.musicArray.push("H1XhvKtIX");
		newList.musicArray.push("rkN2DYY8X");
		newList.musicArray.push("HJBnDFK8Q");
		newList.musicArray.push("ByI3DYKU7");
		newList.musicArray.push("rywhvtYIQ");
		newList.addedBy = "admin";
	    newList.save();
};
module.exports.temp8 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("SkdOFYLX");
		newList.musicArray.push("BkeddtFL7");
		newList.musicArray.push("B1-uuFFLQ");
		newList.musicArray.push("Hyfd_ttIX");
		newList.musicArray.push("BJX_OYYLQ");
		newList.musicArray.push("HJVudYtUm");
		newList.musicArray.push("ByBuuYYUQ");
		newList.musicArray.push("rJI_uKYUX");
		newList.addedBy = "admin";
	    newList.save();
};
module.exports.temp9 = function(req, res) {
		var newList = new listDTO();
		newList._id = new mongoose.Types.ObjectId;
		newList.musicArray.push("SkXYKKUm");
		newList.musicArray.push("Byg7FYKI7");
		newList.musicArray.push("HyZXYtFIQ");
		newList.musicArray.push("SkfmYKKIX");
		newList.musicArray.push("SkQXYFFUQ");
		newList.musicArray.push("H1VQFYtL7");
		newList.musicArray.push("BJrQKtKIQ");
		newList.musicArray.push("ryIXYtYI7");
		newList.musicArray.push("HkwQKYtIX");
		newList.musicArray.push("r1OQKYFIQ");
		newList.musicArray.push("HJF7YFKUX");
		newList.addedBy = "admin";
	    newList.save();
};

*/
