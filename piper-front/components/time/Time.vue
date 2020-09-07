
<template lang='pug'>
.time {{ timeShow }}
</template>

<script lang='coffee'>
App = 
  name: 'Time'
  props:
    time:
      type: Date
      default: null
    
    timeNow:
      type: Date
      default: new Date()

  computed:
    timeDistance: ->
      if @time
        return @timeNow - @time
      else
        return 0

    timeShow: ->
      if @weeks > 0
        return @time.toLocaleString()
      else if @days > 0
        return "#{@days} days ago"
      else if @hours > 0
        return "#{@hours} hours ago"
      else if @minutes > 0
        return "#{@minutes} minutes ago"
      else if @seconds > 0
        return "#{@seconds} seconds ago"
      else
        return ""
      
    seconds: ->
      Math.floor @timeDistance / 1000
    
    minutes: ->
      Math.floor @timeDistance / (1000 * 60)

    hours: ->
      Math.floor @timeDistance / (1000 * 60 * 60)
    
    days: ->
      Math.floor @timeDistance / (1000 * 60 * 60 * 24)
    
    weeks: ->
      Math.floor @timeDistance / (1000 * 60 * 60 * 24 * 7)
  
export default App
</script>