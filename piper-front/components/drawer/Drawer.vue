<template lang='pug'>
div.drawer(:class='drawer_base')
  div.drawer-header
    slot(name='header')
  div.drawer-content
    template(v-if='open')
      div.drawer-content
        slot
    template(v-else)
      div.drawer-content-closed
        slot
</template>

<script lang='coffee'>

App = 
  props:
    position:
      type: String
      default: 'right'
    open:
      type: Boolean
      default: true

  computed:
    drawer_base: ->
      open = if @open then 'open' else 'close'
      return "fixed-#{@position} drawer-#{open}"

export default App
</script>

<style lang='stylus'>
.fixed-left
  position absolute 
  left 0

.fixed-right
  position absolute
  right 0

.drawer-open
  width 10rem

.drawer-close
  width 2rem

.drawer

  display flex
  flex-direction column
  align-items center
  justify-content flex-start

  .drawer-header
    width 100%

  .drawer-content
    flex-grow 1
    width 100%
</style>