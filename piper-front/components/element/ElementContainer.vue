<template lang='pug'>
div.element-container.b-info-darkest
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
    border-box.h-md-2(:type='bottom_border')
    div.element-children
      template(v-for='ele, eleidx in target_elements')
        element-container(
          :flow='flow'
          :idx='ele.idx'
          :position='eleidx'
          :layer='layer + 1'
          :bor_num='target_elements.length'
          @del_element='del_sub_element'
        )
      
    element-container(
      v-if='layer == 0'
      :flow='flow'
      :idx='1'
      :position='0'
      :layer='layer + 1'
      :bor_num='1'
      @del_element='del_sub_element'
    )

    .g-md-5-t.flow-control(v-if='layer == 0')
      .button.add-button New Element
      .button.save-button Save Flow
      .button.export-button Export Flow
</template>

<script lang='coffee'>
import Element from './element.coffee'
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

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/layout.styl'
@import '../../assets/core/color.styl'

.element-container
  box-sizing border-box
  height 100%
  display flex
  flex-direction column
  align-items center

.element-control
  // @extend .g-md-5-b
  width 25rem

.element-children
  display flex
  flex-direction row
  align-items flex-start
  justify-content flex-start

.flow-control
  display flex
  align-items center

  .button
    @extend .bg-info-darkest
    @extend .p-sm-5
    @extend .g-sm-5

    cursor pointer
    color #fff

    &:hover
      @extend .bg-info-dark

</style>