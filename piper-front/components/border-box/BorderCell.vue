<template lang='pug'>
div.border-cell(:class='borderclass')
</template>

<script lang='coffee'>
App = 
  props:
    borders:
      type: Array
      default: -> []
    linestyle:
      type: String
      default: 'solid'

  computed:
    borderclass: ->
      style = @linestyle
      return @borders.map((bname) -> "border-#{bname} border-#{bname}-#{style}").join " "

export default App
</script>

<style lang='stylus'>
$position = 'bottom' 'top' 'left' 'right'
$style = solid dashed

for $pos in $position
  .border-{$pos}
    border-{$pos}-color inherit
    border-{$pos}-width 1px
  for $stl in $style
    .border-{$pos}-{$stl}
      border-{$pos}-style $stl
</style>