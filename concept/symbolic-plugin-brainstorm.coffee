# # Concept symbolic core
# Note: this is pseudo/stub conceptual code

# ## Dependencies

# ### Core modules
fs  = require 'fs'
µ   = require 'util'
Ψ   = require 'child_process'
Ǝ   = require 'events'
Δ  = require 'domain'
_   = require 'underscore'
ρ   = "plugins"
əə  = Ǝ.EventEmitter
δ   = null
ϝ   = "foo"


# stub for some msg simulation
dp = (args...) -> console.log args...

# plugin domain create instance
ρΔ = Δ.create()

ρΔ.run( () ->
  # plugin is created in the scope of the plugin domain outer shell
  dp "register new domain"
  dp "look for plugins"
  dp """
    The first problem we run into: what is a plugin?

    We could take a list of node_modules/
  """
  əə.call @
  @.foo = () ->
    data = "BATMAN"
    @.emit 'balom', data

    # we can even do dom in dom in dom
    inner = Δ.create()
    inner.run(
      dp "inner"
      )


  )

dp ρ
