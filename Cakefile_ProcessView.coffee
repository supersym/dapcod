
# # Process View

# ## Variables acting as constants

# Check the currently running process to find out if the platform is MS Windows.
WINDOWS = process.platform.indexOf('win') is 0

# Run the node.js executable
NODE    = process.execPath

# A generic way of running the Node package manager on all platforms.
NPM     = if WINDOWS then process.execPath.replace('node.exe','npm.cmd') else 'npm'


EXT     = (if WINDOWS then '.cmd' else '')
APP     = process.cwd()
BIN     = "#{APP}/node_modules/.bin"
CAKE    = "#{BIN}/cake#{EXT}"
COFFEE  = "#{BIN}/coffee#{EXT}"
OUT     = "#{APP}/out"
SRC     = "#{APP}/src"
TEST    = "#{APP}/test"




pathUtil = require('path')
{exec,spawn} = require('child_process')
safe = (next,fn) ->
	return (err) ->
		return next(err)  if err
		return fn()


# -----------------
# Actions

clean = (opts,next) ->
	(next = opts; opts = {})  unless next?
	args = [
		'-Rf'
		OUT
		pathUtil.join(APP,'node_modules')
		pathUtil.join(APP,'*out')
		pathUtil.join(APP,'*log')
		pathUtil.join(TEST,'node_modules')
		pathUtil.join(TEST,'*out')
		pathUtil.join(TEST,'*log')
	]
	spawn('rm', args, {stdio:'inherit',cwd:APP}).on('exit',next)

compile = (opts,next) ->
	(next = opts; opts = {})  unless next?
	spawn(COFFEE, ['-bco', OUT, SRC], {stdio:'inherit',cwd:APP}).on('exit',next)

watch = (opts,next) ->
	(next = opts; opts = {})  unless next?
	spawn(COFFEE, ['-bwco', OUT, SRC], {stdio:'inherit',cwd:APP}).on('exit',next)

install = (opts,next) ->
	(next = opts; opts = {})  unless next?
	spawn(NPM, ['install'], {stdio:'inherit',cwd:APP}).on 'exit', safe next, ->
		spawn(NPM, ['install'], {stdio:'inherit',cwd:TEST}).on('exit',next)

reset = (opts,next) ->
	(next = opts; opts = {})  unless next?
	clean opts, safe next, -> install opts, safe next, -> compile opts, next

setup = (opts,next) ->
	(next = opts; opts = {})  unless next?
	install opts, safe next, ->
		compile opts, next

test = (opts,next) ->
	(next = opts; opts = {})  unless next?
	args = []
	args.push("--debug-brk")  if opts.debug
	args.push("#{OUT}/test/everything.test.js")
	args.push("--joe-reporter=list")
	spawn(NODE, args, {stdio:'inherit',cwd:APP}, next)

finish = (err) ->
	throw err  if err
	console.log('OK')


# -----------------
# Commands

# clean
task 'clean', 'clean up instance', ->
	clean finish

# compile
task 'compile', 'compile our files', ->
	compile finish

# dev/watch
task 'dev', 'watch and recompile our files', ->
	watch finish
task 'watch', 'watch and recompile our files', ->
	watch finish

# install
task 'install', 'install dependencies', ->
	install finish

# reset
task 'reset', 'reset instance', ->
	reset finish

# setup
task 'setup', 'setup for development', ->
	setup finish

# test
task 'test', 'run our tests', ->
	test finish

# test-debug
task 'test-debug', 'run our tests in debug mode', ->
	test {debug:true}, finish

# test-prepare
task 'test-prepare', 'prepare out tests', ->
	setup finish

