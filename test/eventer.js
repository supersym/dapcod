var dp, pluginDomain, Ǝ, Δ;
var __slice = Array.prototype.slice;

Ǝ = require('events');

Δ = require('domain');

dp = function() {
  var args;
  args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  return console.log.apply(console, args);
};

pluginDomain = Δ.create();

pluginDomain.run(function() {
  return dp("register plugin");
});

dp(Δ);
