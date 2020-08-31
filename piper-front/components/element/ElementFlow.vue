<template lang='pug'>
div.element-flow(ref='elf')
  template(v-if='flow !== null')
    template(v-for='eleidx in Object.keys(flow.flow_tree)')
      element-control(
        :key='`ele-${eleidx}`'
        :element='flow.flow_tree[eleidx].element'
        :can_link='flow.flow_tree[eleidx].target_elements.length <= 0'
      )
  template(v-if='flow === null')
    div
      div.setup-button(@click='setup_element_flow') Setup Element Flow
      span &nbsp;or&nbsp;
      div.setup-button(@click='load_flow') Load From .flow File
</template>

<script lang='coffee'>
import ElementControl from './ElementControl.vue'
import { Element, Flow } from '../../lib/index.coffee'

App = 
  components: {
    ElementControl
  }

  data: ->
    entry_element: null
    flow: null

  methods:
    setup_element_flow: ->
      @entry_element = new Element 0, 'Entry Element', 'input', {}
      @flow = new Flow @entry_element
    
    load_flow: ->
    
    del_ele: (idx, eidx) ->
    
    add_ele: (idx, eidx, element) ->

    link_ele: (source_element, target_element) ->

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