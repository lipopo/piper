
class App
  onloading: (callback) ->
    if window
      window.onloading = callback

  onloaded: (callback) ->
    if window
      window.onloaded = callback
  
  loading: ->
    if window
      window.onloading()

  loaded: ->
    if window
      window.onloaded()


export default App;