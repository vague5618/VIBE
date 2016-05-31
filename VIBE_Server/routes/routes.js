var feedback  = require('./../controllers/feedback');
var list  = require('./../controllers/list');
var music  = require('./../controllers/music');
var users  = require('./../controllers/users');
var express = require('express');

module.exports = function(app, passport) {
    app.get('/', function(req, res) {
        res.writeHead(200, {"Content-Type": "application/json"});
        res.end("Vibe Server v1.0");
    });

    // Login [x]
    app.post('/login', users.login);
    // Register [x]
    app.post('/signup', users.create); 
    // Search For User by ID [x]
    app.get('/user/search/id/:id', users.read);
    // Search For User by Username [x]
    app.get('/user/search/username/:username', users.readByUsername);
    // Search For User by Username Contain Value
    app.get('/user/search/contain/username/:username', users.readContainsByUsername);

    // My Profile for Currently Logged in User [x]
    app.get('/user/profile', isLoggedIn, users.me); 
    // Update As Currently Logged In User [x]
    app.post('/user/update', isLoggedIn, users.update);
    // Delete Currently Logged in User [x]
    app.delete('/user/delete', isLoggedIn, users.delete);
    // [x]
    app.post('/logout', function(req, res) {
        req.logout();
        res.end('Logged out')
    });

    // Feedback Concept CRUD
    app.post('/feedback/create',feedback.create);
    app.get('/feedback/read/like/:list',feedback.readForLike);
    app.get('/feedback/read/dislike/:list',feedback.readForDislike);
    app.post('/feedback/update',feedback.update);
    app.delete('/feedback/delete',feedback.delete);    
    // LIST Concept CRUD
    app.post('/list/create',list.create);
    app.post('/list/read',list.read);
    app.post('/list/update',list.update);
    app.delete('/list/delete',list.delete);   
    // Music Concept CRUD
    app.post('/music/create',music.create);
    app.post('/music/read',music.read);
    app.post('/music/update',music.update);
    app.delete('/music/delete',music.delete);
    app.post('/music/check',music.check);
    app.post('/music/makeData',music.makeData);
    app.get('/music/start/:id',music.start);   

};

function isLoggedIn(req, res, next) {
    if (req.isAuthenticated())
        return next();
    res.end('Not logged in');
}
