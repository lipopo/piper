class Flash
  onflash: (callback) ->
    window.onflash = callback

  flash: (data) ->
    window.onflash(data)

export default Flash;