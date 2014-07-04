# calls next function if err, otherwise callback.  The next function
# is "baked in" with a closure
onErrCall = (next) ->
  (callback) -> onErr next, callback

# calls next function if err, otherwise callback
onErr = (next, callback) ->
  () ->
    err = arguments[0]
    return next err if err
    callback.apply(this, arguments)

# ignores arguments given to the inner function and uses the
# passed in arguments for the callback (if no error)
onCallbackApply = (args..., callback) ->
  args.unshift null
  () ->
    err = arguments[0]
    return callback err if err
    callback.apply(this, args)

# ignores arguments given to the inner function and uses the
# no arguments for the callback (if no error)
onCallbackDo = (callback) ->
  (err) ->
    return callback err if err
    do callback

# callback that does nothing but log if there is an error
nullCallback = (err) ->
  console.log "#{err}" if err

setGlobal = () ->
  GLOBAL.onErrCall = onErrCall
  GLOBAL.onErr = onErr
  GLOBAL.onCallbackApply = onCallbackApply
  GLOBAL.onCallbackDo = onCallbackDo
  GLOBAL.nullCallback = nullCallback

module.exports = {
  onErrCall: onErrCall
  onErr: onErr
  onCallbackApply: onCallbackApply
  onCallbackDo: onCallbackDo
  nullCallback: nullCallback
  setGlobal: setGlobal
}
