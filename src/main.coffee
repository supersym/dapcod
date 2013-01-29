

# Dependency tree
pathUtil = require('path')

# Thanks to Coffeescript's destructuring assignments capability, you don't have to explicitly import these types
{DocPad,queryEngine,Backbone,createInstance,createMiddlewareInstance} = require(__dirname+'/lib/docpad')

# # Public module members
module.exports =
	# Pre-Defined
	DocPad: DocPad
	queryEngine: queryEngine
	Backbone: Backbone
	createInstance: createInstance
	createMiddlewareInstance: createMiddlewareInstance

	# We offer a static method `require` that the outside world may use and
	# access, effectively performing a self-imposed sanity check on the file
	# system path which got passed as a value stored in the `relative path`
	# variable
	require: (relativePath) ->

		# * to obtain the absolute, normalized path, means we remove any . and ../
		absolutePath = pathUtil.normalize(pathUtil.join(__dirname,relativePath))

		# * check we if are actually a local docpad file
		if absolutePath.replace(__dirname,'') is absolutePath
			throw new Error("docpad.require is limited to local docpad files only: #{relativePath}")

		# * now we check if the path actually exists
		try
			require.resolve(absolutePath)

		# * if it doesn't exist, then try add the lib directory
		catch err
			absolutePath = pathUtil.join(__dirname,'lib',relativePath)
			require.resolve(absolutePath)

		# Finally, require the module at given path
		return require(absolutePath)
