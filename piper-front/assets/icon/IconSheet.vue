<template lang='pug'>
div.icon-sheet
  div.icon-box(
    v-for='icon_name in icon_names'
    @click="() => copy_icon(icon_name)"
  )
    Icon(
      :iconName='icon_name'
      :fontColor='iconColor'
    )
</template>

<script lang='coffee'>
import Icon from './Icon.vue'
import icon_names from './icon.json'

App =
  name: 'IconSheet'

  components: { Icon }

  props:
    iconColor:
      type: String
      default: '#555'

  data: ->
    icon_names: icon_names

  methods:
    copy_icon: (icon_name) ->
      await navigator.clipboard.writeText(
        "Icon(:iconColor='#{icon_name}' :fontColor='#{@iconColor}')"
      )
      alert 'Type Copied!'

export default App
</script>

<style lang='stylus'>
@import '../core/layout.styl'

.icon-sheet
  @extend .p-sm-5
  display flex
  flex-direction row
  flex-wrap wrap
  
  .icon-box
    @extend .p-sm-5
    @extend .g-sm-5
    @extend .g-sm-5-b
    border 1px solid #eee
    width 4rem
    height 4rem
    display flex
    font-size 1.5rem
    flex-direction column
    align-items center
    justify-content center
    cursor pointer

    &:hover
      color #fff
      background #eee

</style>