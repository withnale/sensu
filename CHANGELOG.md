## 0.17.0 - TBD

### Features

Improved Sensu client keepalive event check output.

Hashed initial check request/execution scheduling splay, consistent over
process restarts/reloads.

Sensu event ID logged for event handler output.

### Other

Fixed TLS/SSL on Windows.

Fixed event filtering with event action, eg. `"action": "create"`.

## 0.16.0 - 2014-10-31

### Other

Fixed RabbitMQ transport configuration backwards compatibility.

## 0.15.0 - 2014-10-31

### Features

RabbitMQ transport now supports multiple broker connection options,
enabling connection fail-over to brokers in a cluster without
using a load balancer.

## 0.14.0 - 2014-09-29

### Features

Client socket now supports sending a result via a TCP stream. This feature
allows check results to have larger output (metrics, backtraces, etc).

API now supports CORS (configurable).

Check "source" attribute validation; it must be a string, event data
consumers no longer have to validate it.

### Other

Child process manager now supports check output larger than the max OS
buffer size. The parent process was waiting on the child to exit before
closing its write end of the pipe.

Client & server are now guarding against invalid JSON transport payloads.

## 0.13.1 - 2014-07-28

### Other

Fixed event occurrence count.

## 0.13.0 - 2014-06-12

### Non-backwards compatible changes

API GET /events now provides all event data, the same data passed to event
handlers.

AMQP handler type ("amqp") has been replaced by "transport".

Standalone check results are no longer merged with check definitions
residing on the server(s).

Removed the generic extension type.

Extension stop() no longer takes a callback, and is called when the
eventmachine reactor is stopped.

### Features

Abstracted the transport layer, opening Sensu up to alternative messaging
services.

Event bridge extension type, allowing all events to be relayed to other
services.

Client keepalives now contain the Sensu version.

Support for nested handler sets (not deep).

Setting validation reports all invalid definitions before Sensu exits.

### Other

Clients now only load instances of check extensions, and servers load
everything but check extensions.

Fixed standalone check scheduling, no longer mutating definitions.

Fixed command token substitution, allowing for the use of colons and
working value defaults.

Log events are flushed when the eventmachine reactor stops.

Dropped the Oj JSON parser, heap allocation issues and memory leaks.

Client RabbitMQ queues are no longer server named (bugs), they are now
composed of the client name, Sensu version, and the timestamp at creation.

Server master election lock updates and queries are more frequent.

## 0.12.6 - 2014-02-19

### Non-backwards compatible changes

The "profiler" extension type `Sensu::Extension::Profiler` is now "generic"
`Sensu::Extension::Generic`.

## 0.12.5 - 2014-01-20

### Other

Fixed handler severity filtering, check history is an array of strings.

## 0.12.4 - 2014-01-17

### Other

Fixed filter "eval:" on Ruby 2.1.0, and logging errors.

Fixed handler severity filtering when event action is "resolve". Events
with an action of "resolve" will be negated if the severity conditions have
not been met since the last OK status.

## 0.12.3 - 2013-12-19

### Other

The pipe handler and mutator concurrency limit is now imposed by
`EM::Worker`. A maximum of 12 processes may be spawned at a time.

## 0.12.2 - 2013-11-22

### Other

API routes now have an optional trailing slash.

RabbitMQ initial connection timeout increased from 10 to 20 seconds.

RabbitMQ connection closed errors are now rescued when attempting to
publish to an exchange, while Sensu is reconnecting.

## 0.12.1 - 2013-11-02

### Features

API GET `/stashes` now returns stash expiration information, time
remaining in seconds. eg. [{"path": "foo", "content":{"bar": "baz"},
"expire": 3598}].

### Other

Fixed a config loading bug where Sensu was not ignoring files without a
valid JSON object.

Fixed `handling event` log line data for extensions.

## 0.12.0 - 2013-10-28

### Non-backwards compatible changes

Deprecated API endpoints, `/check/request` and `/event/resolve`, have been
removed. Please use `/request` and `/resolve`.

### Features

API stashes can now expire, automatically removing themselves after `N`
seconds, eg. '{"path": "foo", "content":{"bar": "baz"}, "expire": 600}'.

### Other

Added additional AMQP library version constraints.

Improved API POST data validation.

## 0.11.3 - 2013-10-23

### Other

Fixed redacting sensitive information in log lines during configuration
loading.

Fixed AMQP library dependency version resolution.

Changed to an older version of the JSON parser, until the source of a
memory leak is identified.

## 0.11.2 - 2013-10-23

### Features

Sensu profiler extension support.

Added logger() to the extension API, providing access to the Sensu logger.

## 0.11.1 - 2013-10-16

### Other

Updated "em-redis-unified" dependency version lock, fixing Redis
reconnect when using authentication and/or select database.

## 0.11.0 - 2013-10-02

### Non-backwards compatible changes

WARNING: Extensions compatible with previous versions of Sensu will
NO LONGER FUNCTION until they are updated for Sensu 0.11.x! Extensions
are an experimental feature and not widely used.

Sensu settings are now part of the extension API & are no longer passed
as an argument to run.

TCP handlers no longer have a socket timeout, instead they have a
handler timeout for consistency.

### Features

You can specify the Sensu log severity level using the -L (--log_level)
CLI argument, providing a valid level (eg. warn).

You can specify custom sensitive Sensu client key/values to be redacted
from log events and keepalives, eg. "client": { "redact": [
"secret_access_key" ] }.

You can configure the Sensu client socket (UDP & TCP), bind & port, eg.
"client": { "socket": { "bind": "0.0.0.0", "port": 4040 } }.

Handlers & mutators can now have a timeout, in seconds.

You can configure the RabbitMQ channel prefetch value (advanced), eg.
"rabbitmq": { "prefetch": 100 }.

### Other

Sensu passes a dup of event data to mutator & handler extensions to
prevent mutation.

Extension runs are wrapped in a begin/rescue block, a safety net.

UDP handler now binds to "0.0.0.0".

Faster JSON parser.

AMQP connection heartbeats will no longer attempt to use a closed
channel.

Missing AMQP connection heartbeats will result in a reconnect.

The keepalive & result queues will now auto-delete when there are no
active consumers. This change stops the creation of a keepalive/result
backlog, stale data that may overwhelm the recovering consumers.

Improved Sensu client socket check validation.

AMQP connection will time out if the vhost is missing, there is a lack
of permissions, or authentication fails.

## 0.10.2 - 2013-07-18

### Other

Fixed redacting passwords in client data, correct value is now provided
to check command token substitution.

## 0.10.1 - 2013-07-17

### Features

You can specify multiple Sensu service configuration directories,
using the -d (--config_dir) CLI argument, providing a comma delimited
list.

A post initialize hook ("post_init()") was added to the extension API,
enabling setup (connections, etc.) within the event loop.

### Other

Catches nil exit statuses, returned from check execution.

Empty command token substitution defaults now work. eg. "-f :::bar|:::"

Specs updated to run on OS X, bash compatibility.

## 0.10.0 - 2013-06-27

### Non-backwards compatible changes

Client & check names must not contain spaces or special characters.
The valid characters are: a-z, A-Z, 0-9, "_", ".", and "-".

"command_executed" was removed from check results, as it may contain
sensitive information, such as credentials.

### Features

Passwords in client data (keepalives) and log events are replaced with
"REDACTED", reducing the possibility of exposure. The following
attributes will have their values replaced: "password", "passwd", and
"pass".

### Other

Fixed nil check status when check does not exit.

Fixed the built-in debug handler output encoding (JSON).

## 0.9.13 - 2013-05-20

### Features

The Sensu API now provides /health, an endpoint for connection & queue
monitoring. Monitor Sensu health with services like Pingdom.

Sensu clients can configure their own keepalive handler(s) & thresholds.

Command substitution tokens can have default values
(eg. :::foo.bar|default:::).

Check result (& event) data now includes "command_executed", the command
after token substitution.

### Other

Validating check results, as bugs in older Sensu clients may produce
invalid or malformed results.

Improved stale client monitoring, to better handle client deletions.

Improved check validation, names must not contain spaces or special
characters, & an "interval" is not required when "publish" is false.

## 0.9.12 - 2013-04-03

### Features

The Sensu API now provides client history, providing a list of executed
checks, their status histories, and last execution timestamps. The client
history endpoint is /clients/\<client-name\>/history, which returns a JSON
body.

The Sensu API can now bind to a specific address. To bind to an address,
use the API configuration key "bind", with a string value (eg.
"127.0.0.1").

A stop hook was added to the Sensu extension API, enabling gracefull
stop for extensions. The stop hook is called before the event loop comes
to a halt.

The Sensu client now supports check extensions, checks the run within the
Sensu Ruby VM, for aggresive service monitoring & metric collection.

### Non-backwards compatible changes

The Sensu API stashes route changed, GET /stashes now returns an array of
stash objects, with support for pagination. The API no longer uses POST
for multi-get.

Sensu services no longer have config file or directory defaults.
Configuration paths a left to packaging.

### Other

All Sensu API 201 & 202 status responses now return a body.

The Sensu server now "pauses" when reconnecting to RabbitMQ. Pausing the
Sensu server when reconnecting to RabbitMQ fixes an issue when it is also
reconnecting to Redis.

Keepalive checks now produce results with a zero exit status, fixing
keepalive check history.

Sensu runs on Ruby 2.0.0p0.

Replaced the JSON parser with a faster implementation.

Replaced the Sensu logger with a more lightweight & EventMachine
friendly implementation. No more TTY detection with colours.

Improved config validation.

## 0.9.11 - 2013-02-22

### Features

API aggregate age filter parameter.

### Non-backwards compatible changes

Removed /info "health" in favour of RabbitMQ & Redis "connected".

### Other

No longer using the default AMQP exchange or publishing directly to queues.

Removed API health filter, as the Redis connection now recovers.

Fixed config & extension directory loading on Windows.

Client socket handles non-ascii input.

## 0.9.10 - 2013-01-30

### Features

Handlers can be subdued like checks, suppression windows.

### Non-backwards compatible changes

Extensions have access to settings.

### Other

Client queue names are now determined by the broker (RabbitMQ).

Improved zombie reaping.

## 0.9.9 - 2013-01-14

### Features

RabbitMQ keepalives & results queue message and consumer counts available
via the API (/info).

Aggregate results available via the API when using a parameter
(?results=true).

Event filters; filtering events for handlers, using event attribute
matching.

TCP handler socket timeout, which defaults to 10 seconds.

Check execution timeout.

Server extensions (mutators & handlers).

### Other

Server is now using basic AMQP QoS (prefetch), just enough back pressure.

Improved check execution scheduling.

Fixed server execute command method error handling.

Events with a resolve action bypass handler severity filtering.

Check flap detection configuration validation.

## 0.9.8 - 2012-11-15

### Features

Aggregates, pooling and summarizing check results, very handy for
monitoring a horizontally scaled or distributed system.

Event handler severities, only handle events that have specific
severities.

### Other

Fixed flap detection.

Gracefully handle possible failed RabbitMQ authentication.

Catch and log AMQP channel errors, which cause the channel to close.

Fixed API event resolution handling, for events created by standalone
checks.

Minor performance improvements.

## 0.9.7 - 2012-09-20

### Features

Event data mutators, manipulate event data and its format prior to
sending to a handler.

TCP and UDP handler types, for writing event data to sockets.

API resources now support singular & plural, Rails friendly.

Client safe mode, require local check definition in order to execute
a check, disable for simpler deployment (default).

### Non-backwards compatible changes

AMQP handlers can no longer use `"send_only_check_output": true`, but
instead have access to the built-in mutators `"mutator": "only_check_output"` and
`"mutator": "only_check_output_split"`.

Ruby 1.8.7-p249 is no longer supported, as the AMQP library no longer
does. Please use the Sensu APT/YUM packages which contain an embedded
Ruby.

Client expects check requests to contain a command, be sure to upgrade
servers prior to upgrading clients.

Check subdue options have been modified, "start" is now "begin".

### Other

Improved RabbitMQ and Redis connection recovery.

Fixed API POST input validation.

Redis client connection heartbeat.

Improved graceful process termination.

Improved client socket ping/pong.

Strict dependency version locking.

Adjusted logging level for metric events.
