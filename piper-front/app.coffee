class App
  onloading: (callback) ->
    window.onloading = callback

  onloaded: (callback) ->
    window.onloaded = callback
  
  loading: ->
    window.onloading()

  loaded: ->
    window.onloaded()


export default App;