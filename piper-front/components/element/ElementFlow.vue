<template lang='pug'>
div.element-flow
  template(v-if='element_count > 0' v-for='ec, idx in element_channel')
    div.element-channel(:key='`ec-${idx}`')
      template(v-for='ele, eidx in ec')
        element-control(:element='ele' :key='`ec-${idx}-ele-${eidx}`' @del='(element) => {del_ele(idx, eidx)}' @newele='(element) => {add_ele(idx, eidx, element)}')
  template(v-if='element_count == 0')
    div
      div.setup-button(@click='setup_element_flow') Setup Element Flow
      span &nbsp;or&nbsp;
      div.setup-button(@click='load_flow') Load From .flow File
</template>

<script lang='coffee'>
import ElementControl from './ElementControl.vue'
import { Element } from '../../lib/index.coffee'

App = 
  components: {
      ElementControl
  }

  data: ->
    element_channel: []
    entry_element: null

  computed:
    element_count: ->
      @element_channel.flat().length
    
  methods:
    setup_element_flow: ->
      @entry_element = new Element 0, 'Entry Element', 'input', {}
      @element_channel = [
          [
            @entry_element
          ]
      ]
    
    load_flow: ->
      console.log 'Log Flow'
    
    del_ele: (idx, eidx)->
      @element_channel[idx].splice(eidx, 1)
    
    add_ele: (idx, eidx, element) ->
      if @element_channel.length == idx + 1
        @element_channel.push []
    
      ele_ = new Element 0, 'New Element', 'echo', {}

      @element_channel[idx+1].push ele_

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'

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

    margin-bottom 50px
</style>