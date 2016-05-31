var mongoose = require('mongoose');
var feedbackDTO = require('../DTO/feedbackDTO');

module.exports = {};

module.exports.createFeedback = function(req, res) {
	var newFeedback = new feedbackDTO();
	newFeedback._id = new mongoose.Types.ObjectId;
	newFeedback.musicId = req.body.musicId;
	newFeedback.userId = req.body.userName;
	newFeedback.likeFlag = req.body.likeFlag;
    newFeedback.save();
};

module.exports.readFeedbackForLike = function(req, res) {
	feedbackDTO.count({ listId : req.body.listId, likeFlag : true }, function(err, count){
    	console.log( "Number of docs: ", count );
	});
};

module.exports.readFeedbackForDislike = function(req, res) {
	feedbackDTO.count({ listId : req.body.listId, likeFlag : false }, function(err, count){
    	console.log( "Number of docs: ", count );
	});
};

module.exports.updateFeedback = function(req, res) {
	feedbackDTO.findById(req.body.id, function (err, feed) {
	  if (err) return handleError(err);
	  feed.category = req.body.category;
      feed.singerName = req.body.singerName;
	  feed.musicName = req.body.musicName;
      feed.path = req.body.path;
	  feed.save(function (err) {
	    if (err) return handleError(err);
	    res.send(feed);
	  });
	});
};

module.exports.deleteFeedback = function(req, res) {
	feedbackDTO.remove({ _id : req.body.id }, function(err,removed) {
		if (err) return handleError(err);	
		res.writeHead(200, {"Content-Type": "application/json"});
	    res.end(JSON.stringify(result));
	});
};
