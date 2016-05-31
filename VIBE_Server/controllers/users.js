var userDTO = require('../models/DTO/userDTO');
var userDAO = require('../models/DAO/userDAO');

module.exports.create = function(req, res) {
    userDAO.create(req,res);
};

module.exports.login = function(req, res, next) {
    userDAO.login(req, res, next);
};

module.exports.read = function(req, res) {
    userDAO.read(req, res);
};

module.exports.readByUsername = function(req, res) {
    userDAO.readByUsername(req, res);
};

module.exports.readContainsByUsername = function (req, res) {
	userDAO.readContainsByUsername(req, res);
};

module.exports.me = function(req, res) {
    userDAO.me(req, res);
};

module.exports.update = function(req, res) {
    userDAO.update(req, res);
};

module.exports.delete = function(req, res) {
    userDAO.delete(req, res);
};