<template lang='pug'>
div.element-flow(ref='elf')
  template(v-if='element_count > 0' v-for='ec, idx in element_channel')
    div.element-channel(:key='`ec-${idx}`')
      template(v-for='ele, eidx in ec')
        element-control(
          :element='ele' 
          :key='`ec-${idx}-ele-${eidx}`' 
          @del='(element) => {del_ele(idx, eidx)}' 
          @newele='(element) => {add_ele(idx, eidx, element)}'
          @linkele='(element) => {link_ele(ele, element)}'
        )
  template(v-if='element_count == 0')
    div
      div.setup-button(@click='setup_element_flow') Setup Element Flow
      span &nbsp;or&nbsp;
      div.setup-button(@click='load_flow') Load From .flow File
</template>

<script lang='coffee'>
import { SVG } from '@svgdotjs/svg.js'

import ElementControl from './ElementControl.vue'
import { Element } from '../../lib/index.coffee'

App = 
  components: {
      ElementControl
  }

  data: ->
    element_channel: []
    entry_element: null
    svg: null
  
  mounted: ->
    @svg = SVG().addTo(@$refs.elf).size '100%', '100%'

  computed:
    element_count: ->
      @element_channel.length

  methods:
    get_bottom: (ele) ->
      sl = ele.offsetLeft
      st = ele.offsetTop
      sh = ele.clientHeight
      sw = ele.clientWidth

      x = sl + sw / 2
      y = st + sh
      [x, y]
  
    get_top: (ele) ->
      sl = ele.offsetLeft
      st = ele.offsetTop
      sh = ele.clientHeight
      sw = ele.clientWidth

      x = sl + sw / 2
      y = st
      [x, y]

    line: (source, target) ->
      [x0, y0] = @get_bottom source
      [x1, y1] = @get_top target
      l1 = @svg.line(x0, y0, x0, y0 + (y1 - y0) / 2).stroke {width: 5, color: 'green'}
      l2 = @svg.line(x0, y0 + (y1 - y0) / 2, x1, y0 + (y1 - y0) / 2).stroke {width: 5, color: 'green'}
      l3 = @svg.line(x1, y0 + (y1 - y0) / 2, x1, y1).stroke {width: 5, color: 'green'}
      [l1, l2, l3]

    setup_element_flow: ->
      @entry_element = new Element 0, 'Entry Element', 'input', {}
      @element_channel.push [@entry_element]
    
    load_flow: ->
      console.log 'Log Flow'
    
    del_ele: (idx, eidx) ->
      @element_channel[idx].splice(eidx, 1)
      if @element_channel[idx].length == 0
        @element_channel.splice(idx, 1)
    
    add_ele: (idx, eidx, element) ->
      ele_ = new Element 0, 'New Element', 'echo', {}
      line = @line
      ele_.on_bind = ->
        [l1, l2, l3] = line element.ele, ele_.ele
        console.log l1, l2, l3

      if !@element_channel[idx + 1]
        @element_channel.push []
  
      @element_channel[idx + 1].push(ele_)
      element.link_to ele_

    link_ele: (source_element, target_element) ->
      source_element.link_to target_element

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/color.styl'

.element-flow
  display flex
  flex-direction column
  justify-content flex-start
  align-items center

  position relative

  svg
    position absolute
    z-index -1

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

    width 100%
</style>