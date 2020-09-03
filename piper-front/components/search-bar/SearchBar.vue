<template lang='pug'>
.search-bar
  input.p-sm-5(:placeholder='placeholder' v-model='value')
  div.search-control(v-if='search_able' @click='search')
    Icon.p-sm-5(iconName='search' fontColor='#555') 
</template>

<script lang='coffee'>
import Icon from '../../assets/icon/Icon.vue'

App = 
  name: 'SearchBar'

  components: { Icon }

  props:
    placeholder:
      type: String
      default: ''
    
  data: ->
    value: ''
  
  methods:
    search: ->
      @$emit 'search', @value
      @value = ''
    
  computed:
    search_able: ->
      return @value.length > 0

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/index.styl'

.search-bar
  display flex
  align-items center

  .search-control
    cursor pointer
</style>