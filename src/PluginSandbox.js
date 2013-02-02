var a, b, sandbox, sb, _Singleton;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

sandbox = typeof exports !== "undefined" && exports !== null ? exports : this;

sb = require('sandbox');

sandbox.PluginLoader = (function() {
  var _instance;

  __extends(PluginLoader, require('events').EventEmitter);

  function PluginLoader() {
    PluginLoader.__super__.constructor.apply(this, arguments);
  }

  _instance = void 0;

  PluginLoader.get = function(args) {
    return _instance != null ? _instance : _instance = new _Singleton(args);
  };

  return PluginLoader;

})();

_Singleton = (function() {

  function _Singleton(args) {
    this.args = args;
  }

  _Singleton.prototype.echo = function() {
    return console.log(this.args);
  };

  return _Singleton;

})();

a = sandbox.PluginLoader.get(sb);

a.echo();

b = sandbox.PluginLoader.get('Hello B');

a.echo();

b.echo();
