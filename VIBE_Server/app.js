require('dotenv').load();

var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000,
  mongoose = require('mongoose'),
  passport = require('passport'),
  flash = require('connect-flash'),
  socketio = require('socket.io'),
  morgan = require('morgan'),
  cookieParser = require('cookie-parser'),
  bodyParser = require('body-parser'),
  session = require('express-session');


mongoose.connect( process.env.MONGOLAB_URI, function(err) {
    if (err) throw err;
});

app.use(morgan('dev'));
app.use(cookieParser());
app.use(bodyParser.json({limit: '1000mb'}));
app.use(bodyParser.urlencoded({limit: '1000mb'}));

app.use(session({ secret: 'your secret key' }));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());


require('./config/passport')(passport);
require('./routes/routes')(app, passport);


app.listen(port);
console.log('Server running on port ' + port);
