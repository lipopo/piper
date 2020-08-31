<template lang='pug'>
div.element-container
  template(v-if='element.idx !== undefined')
    element-control(
        :element='element'
    )
    template(v-for='ele in flow.flow_tree[element.idx].target_elements')
      element-container(
          :flow='flow'
          :element='ele'
      )
</template>

<script lang='coffee'>
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

export default App
</script>

<style lang='stylus'>
.element-cotnainer
  display flex
  flex-direction row
</style>