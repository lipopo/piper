<template lang='pug'>
.element-container
  .element-flex.b-info-darkest
    template(v-if='idx !== undefined')
      border-box.h-md-2(:type='top_border')
      element-control.p-sm-1.element-control(
        :idx='idx'
        :element='element'
        :canlink='can_link'
        :layer='layer'
        :position='position'
        :bor_num='bor_num'
        :child_num='target_elements.length'
        :parent_num='source_elements.length'
        @newele='add_sub_element'
        @del='del_element'
        @linkele='link_element'
      )
      border-box.h-md-2.border-bottom(:type='bottom_border')
  
      .element-children
        template(v-for='ele, eleidx in target_elements')
          element-container(
            :flow='flow'
            :idx='ele.idx'
            :position='eleidx'
            :layer='layer + 1'
            :bor_num='target_elements.length'
            @del_element='del_sub_element'
          )
        
      .step-layer
        //- step-layer 用于构建层级的下属层级，让其空白区域实现pad
        border-box.b-info-darkest.step-border(:type='[9,11]')

      template(v-if='layer == 0')
        //- 首层增加concatenate layer
        //- 用于分割下层的应用
        .element-children
  
      .g-md-5-t.flow-control(v-if='layer == 0')
        .button.save-button(@click='save_flow') Save Flow
        .button.concatenate(@click='concate_flow') Concate Flow
        .button.export-button(@click='export_flow') Export Flow
</template>

<script lang='coffee'>
import AppE from '../../app.coffee'
import Element from './element.coffee'

import FlowApi from './flow.api.coffee'
  
import ElementControl from './ElementControl.vue'
import BorderBox from '../border-box/BorderBox.vue'

App =
  name: 'ElementContainer'
  components: {
    BorderBox,
    ElementControl
  }

  props:
    flow:
      type: Object

    idx:
      type: Number
      required: true
  
    layer:
      type: Number
      default: 0
    
    position:
      type: Number
      default: 0
    
    bor_num:
      type: Number
      default: 0
  
  data: ->
    target_elements: [] # 目标元素列表
    source_elements: [] # 源头元素表
    concate_elements: [] # 断接层

  mounted: ->
    # setup target_elements
    @target_elements = [...(@flow_tree[@idx]?.target_elements || [])]
    @source_elemnts = [...(@flow_tree[@idx]?.source_elements || [])]

  computed:
    element: ->
      @flow_tree[@idx]?.element || {}

    flow_tree: ->
      if @flow.flow_tree
        return @flow.flow_tree
      else
        return {}
    
    can_link: ->
      if @target_elements.length == 0 or @element.type == 'split'
        return true
      else 
        return false

    bottom_border: ->
      tp = []
      if @target_elements.length > 0
        tp = [9, 11]
      
      if @target_elements.length == 1
        if @target_elements[0].type == 'concate'
          tp = [...tp, 1,2]
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
    add_sub_element: (element) ->
      new_ele = new Element null, 'Normal Element', 'echo', {}
      @flow.link(@element, new_ele)
      # 本地组件树
      @target_elements.push new_ele

    del_element: () ->
      @$emit 'del_element', @element

    del_sub_element: (element) ->
      target_idx = @target_elements.indexOf element
      @flow.dispatch element
      @target_elements.splice target_idx, 1

    link_element: (element) ->
      @flow.link @element, element
      @update_target_element()
    
    concate_flow: ->
      new_ele = new Element null, 'Concate Element', 'echo', {}
      @flow.link(@element, new_ele)
      @concate_elements.push new_ele

    save_flow: ->
      # @app.loading()
      @flow_api.save_flow(@flow)
    
    export_flow: ->
      # 到处.flow文件
      @flow.export()
    
    new_element: ->
      # 新建 element
      flow = @flow
      con_ele = new Element null, 'Concate Element', 'concate', {}
      element_idxs = Object.keys @flow.flow_tree
      ele_map = element_idxs.map((idx) -> flow.flow_tree[idx]).filter(
        (ele) -> ele.target_elements.length == 0
      )
      # 下发注册事件

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/layout.styl'
@import '../../assets/core/color.styl'

.element-container
  box-sizing border-box
  display inline-block

  .element-flex
    display flex
    flex-direction column
    align-items center
    height 100% 

    .step-layer
      width 100%
      flex-grow 1

      .step-border
        height 100%

.element-control
  // @extend .g-md-5-b
  width 25rem

.element-children
  display flex
  flex-direction row

.flow-control
  display flex

  .button
    @extend .bg-info-darkest
    @extend .p-sm-5
    @extend .g-sm-5

    cursor pointer
    color #fff

    &:hover
      @extend .bg-info-dark

</style>