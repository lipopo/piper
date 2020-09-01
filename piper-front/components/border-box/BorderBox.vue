<template lang='pug'>
div.border-box(:class='padcls')
  div(:class='borderclass')
</template>
<script lang='coffee'>
App = 
  props:
    type:
      type: Array
      default: () => []

  computed:
    borderclass: ->
      cname_list = []
      for bname in @type
        cname_list.push "border-#{@type}"
      return "border-#{@type}"
    
    padcls: ->
      return "pad-#{@type}"

export default App
</script>

<style lang='stylus'>


.pad-top-right
  padding-left 50%

.border-box
  width 100%
  border-color inherit

  .border-base
    height 100%

  .border-none
    border none
  
  .border-bottom
    border-bottom-width 1px
    border-bottom-style solid
  
  .border-top
    border-top-width 1px
    border-top-style solid
  
  .border-left
    border-left-width 1px
    border-left-style solid
  
  .border-right
    border-right-width 1px
    border-right-style solid
  
  .border-top-right
    border-top-width 1px
    border-top-style solid 
    padding-left 50%
</style>