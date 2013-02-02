var dp, fs, µ, Ǝ, əə, Δ, Ψ, δ, ρ, ρΔ, ϝ, _;
var __slice = Array.prototype.slice;

fs = require('fs');

µ = require('util');

Ψ = require('child_process');

Ǝ = require('events');

Δ = require('domain');

_ = require('underscore');

ρ = "plugins";

əə = Ǝ.EventEmitter;

δ = null;

ϝ = "foo";

dp = function() {
  var args;
  args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  return console.log.apply(console, args);
};

ρΔ = Δ.create();

ρΔ.run(function() {
  dp("register new domain");
  dp("look for plugins");
  dp("The first problem we run into: what is a plugin?\n\nWe could take a list of node_modules/");
  əə.call(this);
  return this.foo = function() {
    var data, inner;
    data = "BATMAN";
    this.emit('balom', data);
    inner = Δ.create();
    return inner.run(dp("inner"));
  };
});

dp(ρ);
