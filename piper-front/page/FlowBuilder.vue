<template lang='pug'>
//- Flow Buidler Page
//- 用于构建flow时使用的页面
.flow-builder-page.p-sm-5
  .inline-block
    element-flow
</template>

<script lang='coffee'>
import AppE from '../app.coffee'
import Flash from '../components/flash/flash.coffee'

import Card from '../components/card/Card.vue'
import ElementFlow from '../components/element/ElementFlow.vue'

App = 
  components: { 
    Card,
    ElementFlow
  }
  data: ->
    flash: new Flash()
    app: new AppE()

  methods:
    push_flash: ->
      data =
        iconName: 'cog'
        content: 'Flow Flash'
        type: 'vio'
      @flash.flash data

export default App
</script>

<style lang='stylus'>
@import '../assets/core/layout.styl'

.flow-builder-page
  display flex
  flex-direction column
  width 100%
  height 100%

  overflow auto

</style>