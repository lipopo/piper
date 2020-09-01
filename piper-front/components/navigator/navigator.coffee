Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc

class Navigator
  constructor: (@title, @version, @links) ->

  @property 'append',
    get: -> "#{@title}<span class=\"version\">#{@version}</span>"

  @property 'after',
    get: ->
      (
        @links.map (link) ->
          "<li><a href=\"#{link.link}\">#{link.name}</a></li>" 
      ).join("")
  

export default Navigator;