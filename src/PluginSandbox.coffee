sandbox = exports ? this

sb = require 'sandbox'


class sandbox.PluginLoader extends require('events').EventEmitter

  # Must be declared here to force the closure on the class
  _instance = undefined

  # Must be a static method
  @get: (args) ->
    _instance ?= new _Singleton args


# The actual Singleton class
class _Singleton

  constructor: (@args) ->

  echo: ->

    console.log @args


a = sandbox.PluginLoader.get sb
a.echo()

b = sandbox.PluginLoader.get 'Hello B'
a.echo()
b.echo()


