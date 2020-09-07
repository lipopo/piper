<template lang='pug'>
.trending-card
  .trending-layout
    .trending-header
      .trending-title {{ flowName }}
    .trending-content
      .trending-img
        img(
            v-if='flowPath'
            :alt='flowName'
            :src='flowPath'
        )
        Icon.icon(
          v-else
          iconName='chain-broken'
          fontColor='#555'
          :spin='false'
        )

      .trending-info {{ flowInfo }}
    .trending-footer
      .button(@click='install') Install
</template>

<script lang='coffee'>
import Icon from '../../assets/icon/Icon.vue'

App = 
  components: {
    Icon
  }

  props:
    # 流名称
    flowName:
      type: String
      default: ''
    
    # 流版本
    flowVersion:
      type: String
      default: ''
    
    # 流图像
    flowPath:
      type: String
      default: null
    
    flowInfo:
      type: String
      default: ''
    
    flowId:
      type: String
      default: ''

  methods:
    install: ->
      @$emit 'install', @flowId

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/layout.styl'
@import '../../assets/core/color.styl'
@import '../../assets/core/shape.styl'

.trending-card
  @extend .p-sm-5
  display inline-block

  .trending-layout
    // display
    display flex
    flex-direction column
    align-items center
    justify-content flex-start

    .trending-header
      width 100%
      display flex
      align-items center
      justify-content space-between
    
    .trending-content
      @extend .p-sm-5
      width 100%

      .trending-img
        width 100%
        display inline-block
        text-align center
        height 5rem

        img 
          width 5rem
          height inherit 
        .icon
          font-size 5em
    
    .trending-footer
      width 100%
      display flex
      justify-content flex-end

      .button
        @extend .b-gray-light
        @extend .p-sm-5
        @extend .s-smell

        border-width 1px
        border-style solid
        cursor pointer

        &:hover
          @extend .bg-gray-light
          color #fff
          font-weight bold
</style>