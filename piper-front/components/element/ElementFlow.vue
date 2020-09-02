<template lang='pug'>
div.element-flow(ref='elf')
  //- template(v-if='flow !== null')
  //-   element-container(
  //-     :flow='flow'
  //-     :idx='0'
  //-     @del_element='delflow'
  //-   )

  //-   div.export-button.g-lg-5-t
  //-     div.setup-button(@click='export_flow') Export As .flow File
  template(v-if='flow === null')
    div
      div.setup-button(@click='setup_element_flow') Setup Element Flow
      span &nbsp;or&nbsp;
      div.setup-button(@click='load_flow') Load From .flow File
</template>

<script lang='coffee'>
import Flow from './flow.coffee'
import Element from './element.coffee'
import ElementContainer from './ElementContainer.vue'

App = 
  components: {
    ElementContainer
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
      flow = new Flow
      flow.add @entry_element
      @flow = flow
    
    delflow: ->
      @flow = null
    
    export_flow: ->

    load_flow: ->

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'
@import '../../assets/core/layout.styl'
@import './variable.styl'

.element-flow
  display flex
  flex-direction column
  justify-content flex-start
  align-items center

  .setup-button
    @extend .bg-info-darkest
    @extend .p-sm-5
    color #fff
    display inline
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