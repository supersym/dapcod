var Eventer, Listener, eventer, events, listener, util;

events = require("events");

util = require("util");

Eventer = function() {
  events.EventEmitter.call(this);
  this.kapow = function() {
    var data;
    data = "BATMAN";
    return this.emit("blamo", data);
  };
  return this.bam = function() {
    return this.emit("boom");
  };
};

util.inherits(Eventer, events.EventEmitter);

Listener = function() {
  this.blamoHandler = function(data) {
    console.log("blamo event handled");
    return console.log(data);
  };
  return this.boomHandler = function(data) {
    return console.log("boom event handled");
  };
};

eventer = new Eventer();

listener = new Listener(eventer);

eventer.on("blamo", listener.blamoHandler);

eventer.on("boom", listener.boomHandler);

eventer.kapow();

eventer.bam();
