<template lang='pug'>
div.button
  slot
</template>

<script lang='coffee'>
App = 
  props:
    type: String

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'
.button
  display inline
  padding 5px
</style>