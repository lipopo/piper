<template lang='pug'>
.carousel
  .carousel-left(@click='prev')
    Icon(iconName='angle-left' fontColor='#555' :spin='false')
  .carousel-medium
    slot
  .carousel-right(@click='next')
    Icon(iconName='angle-right' fontColor='#555' :spin='false')
</template>

<script lang='coffee'>
import Icon from '../../assets/icon/Icon.vue'

App = 
  name: 'Carousel'
  components: {
    Icon
  }
  methods:
    prev: ->
      @$emit 'prev'
    
    next: ->
      @$emit 'next'

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/layout.styl'

.carousel
  display flex
  align-items center
  width 100%

  .carousel-left,
  .carousel-right
    @extend .p-sm-5
    height 100%
    display flex
    align-items center
    cursor pointer

  .carousel-medium
    @extend .p-sm-5
    flex-grow 1

  
</style>