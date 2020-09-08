<template lang='pug'>
.split-line(:style='split_style' :class='pad_class')
  .line(:style='border_style')
</template>

<script lang='coffee'>
import Color from '../../assets/core/color.js'

App = 
  name: 'SplitLine'

  props:
    direction:
      type: String
      default: 'row'

    padLevel:
      type: Number
      default: 5

    padType:
      type: String
      default: 'sm'

    type:
      type: String
      default: 'info'
    
  computed:

    row: ->
      if @direction == 'row'
        return true
      else
        return false

    split_style: ->
      _style =
        width: 0
        height: 0

      if @row
        _style['width'] = '100%'
        _style['paddingBottom'] = '0'
        _style['paddingTop'] = '0'
      else
        _style['height'] = '100%'
        _style['paddingRight'] = '0'
        _style['paddingLeft'] = '0'
      return _style
    
    pad_class: ->
      "p-#{@padType}-#{@padLevel}"

    border_style: ->
      _style =
        borderColor: Color[@type]['default']
        borderWidth: '1px'

      if @row
        _style['borderBottomStyle'] = 'solid' 
      else
        _style['borderLeftStyle'] = 'solid' 

      return _style

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/layout.styl'

.split-line
  .line
    width 100%
    height 100%
</style>