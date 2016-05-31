var feedbackDTO = require('../models/DTO/feedbackDTO');
var feedbackDAO = require('../models/DAO/feedbackDAO');

module.exports.create = function(req, res) {
	feedbackDAO.createFeedback(req,res); 
};

module.exports.readForLike = function(req, res) {
	feedbackDAO.readFeedbackForLike(req,res); 
};

module.exports.readForDislike = function(req, res) {
	feedbackDAO.readFeedbackForDislike(req,res); 
};

module.exports.update = function(req, res) {
	feedbackDAO.updateFeedback(req,res); 
};

module.exports.delete = function(req, res) {
	feedbackDAO.deleteFeedback(req,res); 
};
