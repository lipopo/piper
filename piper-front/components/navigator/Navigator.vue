<template lang='pug'>
div.navigator
  template(v-if='navigator !== null')
    div.navigator-append(v-html='navigator.append')
    div.navigator-content {{ navigator.content }}
    div.navigator-after
      ul(v-html='navigator.after')
      div
        slot
</template>

<script lang='coffee'>
import Navigator from './navigator.coffee'

App = 
  props:
    title:
      type: String
      default: ''

    links: 
      type: Array
      default: -> []
    
    version:
      type:String
      default: '' # 版本信息 默认为空

  data: ->
    navigator: null # 导航逻辑应用

  mounted: ->
    @navigator = new Navigator @title, @version, @links

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'
@import '../../assets/core/display.styl'
@import '../../assets/core/layout.styl'

.navigator
  @extend .bg-vio-dark
  @extend .p-sm-5

  display flex

  flex-direction row
  align-items center
  justify-content space-between

  .navigator-append
    color #fff
    font-size 1.2rem
    span.version
      font-size 1rem
      @extend .g-sm-5-l

  .navigator-after
    display flex
    flex-direction row

    ul
      @extend .flex-row
      @extend .align-center
      list-style none

      li
        @extend .g-sm-5
        a
          color #fff
          text-decoration none
</style>