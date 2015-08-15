var MONGO_URI = "mongodb://localhost:27017/test";
var REVENUE_GOAL = 1000;

var express = require('express');
var app = express();

var bodyParser = require('body-parser');

var Q = require('q');
app.use("/static", express.static(__dirname + '/static')); // Serve static files
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.listen(1337); // The best port
console.log("App running on http://localhost:1337");

// Serve homepage
app.get("/",function(request,response){

    console.log("Entered / app.get function");
    response.send(
        "<link rel='stylesheet' type='text/css' href='/static/fancy.css'>"+
        "<h1>Your Crowdfunding Campaign</h1>"+
        "<h2>raised tons of monies!!! out of $"+REVENUE_GOAL.toFixed(2)+"</h2>"+
        "<a href='/fund'>Fund This</a>"
    );

    Q.fcall(_getTotalFunds).then(function(total){
        response.send(
            "<link rel='stylesheet' type='text/css' href='/static/fancy.css'>"+
            "<h1>Your Crowdfunding Campaign</h1>"+
            "<h2>raised $"+total.toFixed(2)+" out of $"+CAMPAIGN_GOAL.toFixed(2)+"</h2>"+
            "<a href='/fund'>Fund This</a>"
        );
    });

});

// Serve funding page
app.get("/fund",function(request,response){
    response.sendfile("fund.html");
});

// Recording a Donation
var mongo = require('mongodb').MongoClient;
function _recordDonation(donation){

    // Promise saving to database
    var deferred = Q.defer();
    mongo.connect(MONGO_URI,function(err,db){
        if(err){ return deferred.reject(err); }

        // Insert donation
        db.collection('donations').insert(donation,function(err){
            if(err){ return deferred.reject(err); }

            // Promise the donation you just saved
            deferred.resolve(donation);

            // Close database
            db.close();

        });
    });
    return deferred.promise;

}

// Get total donation funds
function _getTotalFunds(){

    // Promise the result from database
    var deferred = Q.defer();
    mongo.connect(MONGO_URI,function(err,db){
        if(err){ return deferred.reject(err); }

        // Get amounts of all donations
        db.collection('donations')
        .find( {}, {amount:1} ) // Select all, only return "amount" field
        .toArray(function(err,donations){
            if(err){ return deferred.reject(err); }

            // Sum up total amount, and resolve promise.
            var total = donations.reduce(function(previousValue,currentValue){
                return previousValue + currentValue.amount;
            },0);
            deferred.resolve(total);

            // Close database
            db.close();

        });
    });
    return deferred.promise;

}