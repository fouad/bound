class Bound
  constructor: (obj, el) ->
    # setup defaults
    @attributes = {}
    @frozen = false
    @el = el
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
    @attributes[key]['value'] = value
    final = value
    # check if there's even a handler
    if @attributes[key]['handler']?
      # get the final handler version of the value
      final = @attributes[key]['handler'](value)
    # update DOM element
    if not @frozen
      $el = @el.querySelector ".bound-#{key}"
      $el.textContent = final

  render: ->
    for key of @attributes
      # set default values
      @set key, @attributes[key]['value']

  freeze: ->
    @frozen = not @frozen

bound = (obj, el) ->
  if not obj? or not el?
    throw new Error("bound - missing parameter")

  new Bound obj, el

module.exports = bound