var shortId = require('shortid');
var mongoose = require('mongoose');

var musicSchema = mongoose.Schema({
    _id : {
	    type: String,
	    default: function() { return shortId.generate(); }
	},
    singerName: String,
    musicName: String,
    albumName: String,
    lyrics: String,
    length: String,
    pathName: String
});

module.exports = mongoose.model('Music', musicSchema);	