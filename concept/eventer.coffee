events = require("events")
util = require("util")

# The Thing That Emits Event

Eventer = () ->
  events.EventEmitter.call this
  @kapow = ->
    data = "BATMAN"
    @emit "blamo", data

  @bam = ->
    @emit "boom"

util.inherits Eventer, events.EventEmitter

# The thing that listens to, and handles, those events
Listener = () ->
  @blamoHandler = (data) ->
    console.log "blamo event handled"
    console.log data

  @boomHandler = (data) ->
    console.log "boom event handled"


# The thing that drives the two.
eventer = new Eventer()
listener = new Listener(eventer)
eventer.on "blamo", listener.blamoHandler
eventer.on "boom", listener.boomHandler
eventer.kapow()
eventer.bam()
