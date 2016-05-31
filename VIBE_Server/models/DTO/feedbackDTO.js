var shortId = require('shortid');
var mongoose = require('mongoose');

var feedbackSchema = mongoose.Schema({	
	_id : {
	    type: String,
	    default: function() { return shortId.generate(); }
	},
	listId : String, 
	userId : String,
	likeFlag : Boolean
});

module.exports = mongoose.model('FeedBack', feedbackSchema);