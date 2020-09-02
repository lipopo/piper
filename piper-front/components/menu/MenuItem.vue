<template lang='pug'>
div.menu-item.p-sm-5(
  :class='item_class'
  :style='item_style'
  @mouseenter='active_hover'
  @mouseleave='deactive_hover'
  )
  slot
</template>

<script lang='coffee'>

App = 
  props:
    active:
      type: Boolean
      default: false
    
    fontColor:
      type: String
      default: '#555'
    
    bgColor:
      type: String
      default: '#fff'
    
    bgActiveColor:
      type: String
      default: '#fff'
    
    bgHoverColor:
      type: String
      default: '#fff'
  
  data: ->
    hover: false

  computed:
    item_class: ->
      if @active
        return 'item-active'
      else
        return ''
    
    item_style: ->
      if @active
        _style = 
          color: @fontColor
          backgroundColor: @bgActiveColor
      else if @hover
        _style = 
          color: @fontColor
          backgroundColor: @bgHoverColor
      else
        _style = 
          color: @fontColor
          background: @bgColor
      return _style
  
  methods:
    active_hover: ->
      @hover = true
    
    deactive_hover: ->
      @hover = false

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/layout.styl'

.menu-item
  display flex
  align-items center
  justify-content flex-start
  width 100%
  cursor pointer

.item-active
  font-weight bold

</style>