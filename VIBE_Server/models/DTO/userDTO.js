var shortId = require('shortid');
var mongoose = require('mongoose');
var bcrypt   = require('bcrypt-nodejs');
var md5 = require('MD5');

var userSchema = mongoose.Schema({
	  _id : {
      type: String,
      default: function() { return shortId.generate(); }
    },
    name: String,
    desc: String, 
    username: String,
    password: String,
    email: String,
  	avatar: String,
  	isAdmin: Boolean
});

userSchema.methods.generateHash = function(password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

userSchema.methods.validPassword = function(password) {
    return bcrypt.compareSync(password, this.password);
};

module.exports = mongoose.model('User', userSchema);