<template lang="pug">
div.layout
  div.nav
    Navigator(title='Piper' :version='version')
  div.content
    Drawer.drawer.p-sm-5(:open='drawer_open')
      div(slot='header')
        span(@click='open_drawer') O
    div.com-content.p-sm-5
      component(:is='content')

</template>

<script>
import { version } from './lib/index.coffee';
import Drawer from './components/drawer/Drawer.vue';
import Navigator from './components/navigator/Navigator.vue';
// import ElementFlow from './components/element/ElementFlow.vue';

export default {
  components: {
    Navigator,
    Drawer,
    // ElementFlow
  },
  data() {
    return {
      version: version,
      drawer_open: false,
      content: null
    }
  },
  methods: {
    open_drawer: function() {
      this.drawer_open = !this.drawer_open;
    }
  }
}
</script>

<style lang='stylus'>
@import './App.styl'

.layout
  height 100vh
  display flex
  flex-direction column
  .content
    flex-grow 1
    .drawer
      @extend .bg-vio-darkest
      height 100%
      color #fff
      justify-content flex-end
    .com-content
      height 100%
      .content-card
        display flex

</style>