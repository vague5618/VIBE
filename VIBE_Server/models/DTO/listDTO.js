var shortId = require('shortid');
var Music = require('./musicDTO');
var User = require('./userDTO');
var mongoose = require('mongoose');

var listSchema = mongoose.Schema({
    _id : {
	    type: String,
	    default: function() { return shortId.generate(); }
	},
    musicArray : [Music._id],
    addedBy : [User.username]
});

module.exports = mongoose.model('List', listSchema);