<template lang='pug'>
div.element-control(ref='elc')
  element-component(:element='element')
  div.delete-button(@click='delete_element') x
  div.link-button(
    v-if='can_link'
    @click='link_new_element'
    ) +

</template>

<script lang='coffee'>
import { Element } from '../../lib/index.coffee'
import ElementComponent from './Element.vue'

App =
  components: {
      ElementComponent
  }

  props:
    element:
      type: Object
      required: true
    
  mounted: ->
    @element.bind @$refs.elc

  methods:
    delete_element: ->
      @$emit 'del', @element
    
    link_new_element: ()->
      @$emit 'newele', @element
    
    link_element: () ->
      if @element != window.source_element
        @$emit 'linkele', @element
  
  computed:
    can_link: ->
      @element.type == 'split' || @element.target_element.length == 0

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'

.element-control
  @extend .b-info-darkest
  border-width 1px
  border-style dashed

  padding calc(1rem + 4px)

  position relative

  .delete-button
    position absolute
    padding 0 5px
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