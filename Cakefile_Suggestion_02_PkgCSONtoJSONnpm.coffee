
# # Suggestion 02
# Support package.cson conversion if present.


WINDOWS = process.platform.indexOf('win') is 0
NODE    = process.execPath
NPM     = if WINDOWS then process.execPath.replace('node.exe','npm.cmd') else 'npm'
EXT     = (if WINDOWS then '.cmd' else '')
APP     = process.cwd()
BIN     = "#{APP}/node_modules/.bin"
CAKE    = "#{BIN}/cake#{EXT}"
COFFEE  = "#{BIN}/coffee#{EXT}"
OUT     = "#{APP}/out"
SRC     = "#{APP}/src"
TEST    = "#{APP}/test"

# needed for checking if package.cson exists
fs = require('fs')

pathUtil = require('path')
{exec,spawn} = require('child_process')
safe = (next,fn) ->
	return (err) ->
		return next(err)  if err
		return fn()


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

  # Check for package.cson file exists
  fs.exists "./package.cson", (exists) ->
    spawn("cson2json package.cson | sed 's/\\n/ /g'")
    
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


# Commands

task 'clean', 'clean up instance', ->
	clean finish

task 'compile', 'compile our files', ->
	compile finish

task 'dev', 'watch and recompile our files', ->
	watch finish

task 'watch', 'watch and recompile our files', ->
	watch finish

task 'install', 'install dependencies', ->
	install finish

task 'reset', 'reset instance', ->
	reset finish

task 'setup', 'setup for development', ->
	setup finish

task 'test', 'run our tests', ->
	test finish

task 'test-debug', 'run our tests in debug mode', ->
	test {debug:true}, finish

task 'test-prepare', 'prepare out tests', ->
	setup finish

