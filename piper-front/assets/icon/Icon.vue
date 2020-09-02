<template lang='pug'>
div.fa(:class="icon_cls" :style="{color: fontColor}")
</template>

<script lang='coffee'>
import 'font-awesome/css/font-awesome.min.css'

App = 
  props:
    iconName:
      type: String
      default: null
    spin:
      type: Boolean
      default: false
    fontColor:
      type: String
      default: '#ccc'
  
  computed:
    icon_cls: ->
      cls_map = []
      if @spin
        cls_map.push "fa-spin"
      if @iconName
        cls_map.push "fa-#{@iconName}"
      return cls_map.join(" ") 

export default App
</script>

<style lang='stylus'>
</style>