<template lang='pug'>
input.input(:ref="`${name}-input`")
</template>

<script lang='coffee'>
App = 
  props:
    name:
      type: String
      default: null
    defaultValue:
      type: String
      default: ''
  mounted: ->
    @$refs['#{@name}-input'].defaultValue = @defaultValue

export default App
</script>

<style lang='stylus'>


</style>