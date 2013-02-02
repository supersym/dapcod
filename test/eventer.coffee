Ǝ = require 'events'
Δ = require 'domain'


dp = (args...) -> console.log args...

pluginDomain = Δ.create()

pluginDomain.run( () ->
  # plugin is created in the scope of the plugin domain outer shell
  dp "register plugin"

  )

dp Δ
