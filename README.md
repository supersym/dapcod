Conceptual

Goal: define a framework for flexible, multilingual, event processing in a structured manner that will also better enable multiple docpad instances.

## Abstract

There are a few 'shortcommings' in the current way docpad is setup. Each problem area should be delt with seperately, for this I have created `core/something` branches. Since events are so elementary to node.js, they should be extra special in docpad.

Events in the broadest sense of the word, could be machine signals, like `SIGINT`. Proper event processing in docpad would account for these 'events' in a certain way. But, perhaps even more important, a structured abstraction layer of events in docpad, would solve many of our (future) challenges



Requirements: Secure and unambiguous means of processing internal, external information to the user in terms of system events that are pre-defined so that we may work with translation files.

We should have a uniform, simple but elegant and complete system of dealing with
key events, parsing and communicating to users.

## Use-case

### Situation
Plugin developer wants to gracefully handle exceptions and ask the user a question or two.

### Current approach (As Is)
Developer writes code that throws a (custom) exception, docpad fetches (?) optionally provides a message (in English). Options can be set using configuration file in the plugin (or through using docpad.cson file?)

### Possible approaches (Could Be's)

#### Symbolic resolution of structured messages
Developer still writes logical conditions but instead of using `throw Error` uses `$.error` This automatically resolves to the ⚡ sign for internal signalling (anything besides unhandled exception? there could also be a SIG or `catch...try` final just-in-time docpad `sandbox` structure that deals with anything not set inside the plugin)

Note: I would expect that some degree of quality in commenting/documenting plugins will eventually be demanded/expected. This also goes for literately writing out the logic/rationale behind the code and choices that were made. This will better ensure plugin developers will create "well behaving apps" specifically for docpad.


 writer wants to
have some error handling but doesn't want to translate it into 10, 20 languages.

These components are supposed to work as follow:
a. core docpad events are messages
b. these events are custom, short names
c. following all event processing, the logic comes behind but its a double sided approach.
e.g.

```coffee-script
if something
  event.conflict  unless x?

else

  event.success
  event.finish

```

Which result


