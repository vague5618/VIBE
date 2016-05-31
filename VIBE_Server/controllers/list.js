var listDTO = require('../models/DTO/listDTO');
var listDAO = require('../models/DAO/listDAO');

module.exports.create = function(req, res) {
	listDAO.createList(req,res); 
};

module.exports.read = function(req, res) {
	listDAO.readList(req,res); 
};

module.exports.update = function(req, res) {
	listDAO.updateList(req,res); 
};

module.exports.delete = function(req, res) {
	listDAO.deleteList(req,res);
};
/*
module.exports.temp = function (req, res) {
	listDAO.temp1(req,res);
	listDAO.temp2(req,res);
	listDAO.temp3(req,res);
	listDAO.temp4(req,res);
	listDAO.temp5(req,res);
	listDAO.temp6(req,res);
	listDAO.temp7(req,res);
	listDAO.temp8(req,res);
	listDAO.temp9(req,res);
}
*/