<template lang='pug'>
div.element-container.b-info-darkest
  template(v-if='idx !== undefined')
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

</style>