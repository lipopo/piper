<template lang='pug'>
div.element-control
  border-box.h-md-2(:type='top_border')
  element-component(
    :idx='idx'
    :element='element'
  )
    template(v-slot:append)
      div.delete-button.z-control-layer(@click='delete_element') x
  border-box.h-md-2(:type='bottom_border')
  div.link-button.z-control-layer(
    v-if='canlink'
    @click='link_new_element'
  ) +

</template>

<script lang='coffee'>
import Element from './element.coffee'
import ElementComponent from './Element.vue'
import BorderBox from '../border-box/BorderBox.vue'

App =
  components: {
    ElementComponent,
    BorderBox
  }

  props:
    idx:
      type: Number
      required: true

    element:
      type: Object
      required: true
    
    canlink:
      type: Boolean
      default: true
    
    position:
      type: Number
    
    layer:
      type: Number

    bor_num:
      type: Number

    child_num:
      type: Number
  
  computed:
    bottom_border: ->
      tp = []
      if @child_num > 0
        tp = [9, 11]
      return tp
    
    top_border: ->
      tp = []
      if @layer > 0
        tp = [...tp, 9, 11]
        if @bor_num > 1
          if @position == 0
            tp = [...tp, 5]
          else if @position == @bor_num - 1
            tp = [...tp, 6]
          else
            tp = [...tp, 5, 6]
      return tp
  
  methods:
    delete_element: ->
      @$emit 'del', @element
    
    link_new_element: ()->
      @$emit 'newele', @element
    
    link_element: () ->
      if @element != window.source_element
        @$emit 'linkele', @element

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'
@import '../../assets/core/layout.styl'
@import './variable.styl'

.element-control
  position relative

  .source-link-row
    @extend .b-info-darkest
    border-left-width 4px
    border-left-style solid

    position absolute
    left 50%
    height ($channel-space / 2 - 5px)
    top -($channel-space / 2 + 5px)

    &:before
      content ''
      height 0
      width 100px

      position absolute
      top 0
      left calc(50% + 1px)
      
      @extend .b-info-darkest
      border-top-width 5px
      border-top-style solid

    &:after
      content ''
      height 0 
      width 0

      @extend .b-info-darkest
      border-width 8px
      border-style solid
      border-bottom-color transparent
      border-left-color transparent
      border-right-color transparent

      position absolute
      top calc(100% + 1px)
      transform translate(calc(-50% - 2px), 0)

  .link-row
    @extend .b-info-darkest
    border-left-width 4px

    border-left-style solid

    position absolute
    top calc(100% + 1px)
    left 50%
    height ($channel-space / 2 - 1px)
    
  .delete-button
    padding 0 5px
    width auto
    top 2px
    right 2px
    cursor pointer
  
    &:hover
      @extend .bg-info-darkest
      color #fff
      font-weight bold

  .link-button
    @extend .bg-info-darkest
    padding 0 5px

    position absolute
    top 100%
    left 50%
    transform translate(-50%, -50%)

    color #fff
    font-weight bold
    cursor pointer

</style>