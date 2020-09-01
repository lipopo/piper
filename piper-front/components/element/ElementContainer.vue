<template lang='pug'>
div.element-container
  template(v-if='element.idx !== undefined')
    element-control.g-md-5-b(
      :element='element'
      @newele='add_sub_element'
      @del='del_element'
      @linkele='link_element'
    )
    div.element-children
      template(v-for='ele in target_elements')
        element-container(
          :flow='flow'
          :element='ele'
        )
</template>

<script lang='coffee'>
import Element from './element.coffee'
import ElementControl from './ElementControl.vue'

App =
  name: 'ElementContainer'
  components: {
      ElementControl
  }

  props:
    flow:
      type: Object
    element:
      type: Object

  data: ->
    target_elements: [] # 目标元素列表

  mounted: ->
    @target_elements = @flow_tree[@element.idx]?.target_elements || []

  computed:
    flow_tree: ->
      if @flow.flow_tree
        return @flow.flow_tree
      else
        return {}

  methods:
    update_target_element: () ->
      @target_elements = @flow.flow_tree[@element.idx].target_elements

    add_sub_element: (element) ->
      new_ele = new Element null, 'Normal Element', 'echo', {}
      @flow.link(@element, new_ele)
      # 更新目标元素
      @update_target_element

    del_element: (element) ->
      @flow.dispatch element
      @update_target_element
    
    link_element: (element) ->
      @flow.link @element, element
      @update_target_element

export default App
</script>

<style lang='stylus'>
@import '../../assets/core/layout.styl'

.element-children
  display flex
  flex-direction row
  align-items center
  justify-content flex-start
</style>