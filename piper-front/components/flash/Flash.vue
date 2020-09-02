<template lang='pug'>
div.flash(:class='color')
  div
    Icon.g-sm-5(:iconName='iconName' fontColor='#fff')
    span {{ content }}
  div(@click='close_flash')
    Icon.close-button(
      iconName='close'
      fontColor='#fff')
</template>

<script lang='coffee'>
import Icon from '../../assets/icon/Icon.vue'

App = 
  components: {
    Icon
  }

  props:
    iconName:
      type: String
      default: 'music'

    type:
      type: String
      default: 'info'
    
    content:
      type: String
      default: ''
  
  computed:
    color: ->
      "bg-#{@type}-light"
  
  methods:
    close_flash: ->
      @$emit 'close'

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'
@import '../../assets/core/layout.styl'

.flash
  @extend .p-sm-5
  color #fff
  display flex
  flex-direction row
  align-items center
  justify-content space-between
  width 100%
  .close-button
    cursor pointer
</style>