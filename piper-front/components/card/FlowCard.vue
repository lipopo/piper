<template lang='pug'>
.flow-card
  .flow-card-layout
    .flow-card-header
      .flow-title.p-sm-5(v-if='flowName') {{ flowName }}
    .flow-card-content
      .flow-img(v-if='imgPath')
        img(:src='imgPath')
      .flow-icon(v-else)
        Icon(iconName='chain-broken' fontColor='#555' :spin='false')
    .flow-card-footer
      Time(:time='time' :timeNow='now')
</template>

<script lang='coffee'>
import Icon from '../../assets/icon/Icon.vue'
import Time from '../time/Time.vue'

App = 
  name: 'FlowCard'
  props:
    flowName:
      type: String
      default: ''
    imgPath:
      type: String
      default: ''
    updateTime:
      type: String
      default: ''
    now:
      type: Date
      default: new Date() 

  components: { 
    Icon,
    Time
  }

  computed:
    time: ->
      new Date(@updateTime)

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'
@import '../../assets/core/rotate.styl'
@import '../../assets/core/layout.styl'
@import '../../assets/core/math.styl'


.flow-card
  display inline-block
  height 100%
  width 100%

  .flow-card-layout
    display flex
    flex-direction column
    position relative

    width inherit
    height inherit

    .flow-card-header
      display flex
      align-items center
      position absolute
      top -10px
      left 10px

      .flow-title
        @extend .bg-info-light
        color #fff
        position relative 

        &:before
          @extend .b-info-dark
          @extend .r-Z-45
          content: ''
          position absolute
          left -10px * ($sqrt2 / 2)
          top 5px * $sqrt2 - 4px
          height 0
          width 0
          border-width 5px * $sqrt2
          border-style solid
          border-right-color transparent
          border-top-color transparent
          border-bottom-color transparent

    .flow-card-content
      width 100%
      height 100%
      .flow-icon
        width inherit
        height inherit

        display flex
        align-items center
        justify-content center

        font-size 4rem
    
    .flow-card-footer
      @extend .p-sm-5
      @extend .bg-info-light
      position absolute
      bottom -7px 
      right 5px
      color #fff

      &:after
        @extend .r-Z-45
        @extend .b-info-dark
        content ''
        height 0
        width 0

        position absolute
        bottom 2px
        right -5px

        border-width 5px
        border-style solid

        border-left-color transparent
        border-top-color transparent
        border-bottom-color transparent
</style>