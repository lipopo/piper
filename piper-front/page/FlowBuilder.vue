<template lang='pug'>
//- Flow Buidler Page
//- 用于构建flow时使用的页面
div.flow-builder-page
  Card.inline-block(:style="{border: '1px solid #eee'}")
    button(@click='push_flash') Build Flow
    button(@click='app.loading') Set Loading
    button(@click='app.loaded') Set Loaded
</template>

<script lang='coffee'>
import AppE from '../app.coffee'

import Card from '../components/card/Card.vue'
import Flash from '../components/flash/flash.coffee'

App = 
  components: { Card }
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
</style>