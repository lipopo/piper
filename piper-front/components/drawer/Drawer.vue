<template lang='pug'>
div.drawer
  div.drawer-header
    span(@click='switch_drawer') icon {{ open }}
  template(v-if='open')
    div.drawer-content Content
  template(v-else)
    div.drawer-content-closed Contenter
</template>

<script lang='coffee'>

App = 
  props:
    position:
      type: String
      default: 'left'

  data: ->
    open: false

  methods:
    switch_drawer: ->
      @open = !@open

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'
@import '../../assets/core/layout.styl'

.drawer
  @extend .bg-vio-dark
  @extend .p-sm-5

  display flex
  flex-direction column
  align-items center
  justify-content flex-start
  color #fff

  .drawer-header
    @extend .p-sm-5
    border-bottom-color #fff
    border-bottom-width 1px
    border-bottom-style solid

    width 500px

    display flex
    flex-direction row
    align-items center
    justify-content flex-end
    cursor pointer

  .drawer-content
    @extend .p-sm-5
    flex-grow 1
</style>