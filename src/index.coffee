query = require("query")

class Bound
  constructor: (obj, selector) ->
    # setup defaults
    @attributes = {}
    @frozen = false
    @selector = selector
    for key of obj
      if obj[key]['value']?
        @attributes[key] = obj[key]
      else
        @attributes[key] =
          value: obj[key]
  
  get: (key) ->
    @attributes[key]['value']

  set: (key, value) ->
    if not @attributes[key]?
      @attributes[key] =
        value: value
    # check if there's even a handler
    if @attributes[key]['handler']?
      # set the value of the object to handler version of it
      value = @attributes[key]['handler'](value)
    @attributes[key]['value'] = value
    # update DOM element
    if not @frozen
      $el = query "#{@selector} .bound-#{key}"
      $el.textContent = @attributes[key]['value']

  render: ->
    for key of @attributes
      # set default values
      @set key, @attributes[key]['value']

  freeze: ->
    @frozen = not @frozen

bound = (obj, selector) ->
  if not obj? or not selector?
    throw new Error("bound - missing parameter")

  new Bound obj, selector

module.exports = bound