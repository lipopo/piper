<template lang='pug'>
div.element-flow(ref='elf')
  template(v-if='flow === null')
    div
      div.setup-button(@click='setup_element_flow') Setup Element Flow
      span &nbsp;or&nbsp;
      div.setup-button(@click='load_flow') Load From .flow File
</template>

<script lang='coffee'>
import ElementControl from './ElementControl.vue'
import Flow from './flow.coffee'
import Element from './element.coffee'

App = 
  components: {
    ElementControl
  }

  data: ->
    entry_element: null
    element_array: []
    flow: null
  
  computed:
    element_count: ->
      @element_array.length

  methods:
    setup_element_flow: ->
      @entry_element = new Element 0, 'Entry Element', 'input', {}
      @flow = new Flow @entry_element
    
    load_flow: ->
    
    del_ele: (element) ->
      empty_flow = @flow.dispatch element
      if empty_flow
        @flow = null
    
    add_ele: (source_element) ->
      # create new element
      new_element = new Element null, 'Normal Element', 'echo', {}
      @flow.link source_element, new_element

    link_ele: () ->

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'
@import './variable.styl'

.element-flow
  display flex
  flex-direction column
  justify-content flex-start
  align-items center

  .setup-button
    @extend .bg-info-darkest
    color #fff

    display inline

    padding 5px
    cursor pointer

    &:hover
      @extend .bg-info-dark

  .element-channel
    display flex
    flex-direction row
    align-items center
    justify-content space-around
    width 100%

    margin-bottom $channel-space
</style>