
# # Development View

# CoffeeScript is a language that compiles into JavaScript and this adds another layer to your development process:
# [compile time](http://en.wikipedia.org/wiki/Compile_time). Having to manually compile CoffeeScript files whenever they
# change quickly gets old, thats why there are
# [several build tools available](https://github.com/jashkenas/coffee- # script/wiki/Build-tools).

# CoffeeScript also has a native form of build process support which can make the development cycle somewhat smoother.
# This is what DocPad currently uses.

# Cake is a super simple build system along the lines of Make and Rake. The
# library is bundled with the coffee-script npm package, and available via an
# executable called `cake`.

# -------

# First we define a few variables. Keep in mind, JavaScript is a dynamically typed language and CoffeeScript does not
# add any type checking features during compile time. However, you may find these variables to appear as constants, due
# to C++ and Java, where it is a well established naming convention. In these languages constants should be written all
# uppercase, with underscores to separate words. Their use, at the top of the Cakefile however, implies that these
# variables are treated as constants. Although their values are initially set in an dynamic way (by use of other
# variables, methods return values) or rather literal with some substring replacement, it probably means that their
# values are not overwritten elsewhere.

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




# You can define tasks using CoffeeScript in this file called Cakefile. Cake will
# pick these up, and can be invoked by running `cake [task] [options]` from within
# the directory. To print a list of all the tasks and options, just type cake.

# Tasks are defined using the `task()` function, passing a name, optional
# description and callback function.

# This file was originally created by Benjamin Lupton <b@lupton.cc>
# (http://balupton.com) and is currently licensed under the Creative Commons
# Zero (http://creativecommons.org/publicdomain/zero/1.0/) making it public
# domain so you can do whatever you wish with it without worry (you can even
# remove this notice!)
#
# If you change something here, be sure to reflect the changes in:
# - the scripts section of the package.json file
# - the .travis.yml file





# -----------------
# Requires

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

