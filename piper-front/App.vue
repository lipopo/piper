<template lang="pug">
div.layout
  div.nav
    Navigator(title='Piper' :version='version')
  div.content
    Drawer.drawer(:open='drawer_open')
      div.drawer-header.p-sm-5(slot='header' @click='open_drawer')
        span.flow-icon o
      Menu(
        :fontColor='"#fff"'
        :menuBgColor='Color.vio.darkest'
        :itemActiveColor='Color.vio.default'
        :itemHoverColor='Color.vio.dark'
        :items='menu_item'
        @active
      )
    div.com-content.p-sm-5
      component(:is='content')

</template>

<script>
import { version } from './lib/index.coffee';
import Color from './assets/core/color.js';
import Drawer from './components/drawer/Drawer.vue';
import Menu from './components/menu/Menu.vue';
import Navigator from './components/navigator/Navigator.vue';
// import ElementFlow from './components/element/ElementFlow.vue';

export default {
  components: {
    Navigator,
    Drawer,
    Menu
    // ElementFlow
  },
  data() {
    return {
      version: version,
      drawer_open: false,
      content: null,
      base_menu_item: [
        {name: 'Flow', icon:'flow'},
        {name: 'Config', icon: 'flow'}
      ],
      Color: Color
    }
  },
  methods: {
    open_drawer: function() {
      this.drawer_open = !this.drawer_open;
    }
  },
  computed: {
    menu_item: function() {
      if(this.drawer_open) {
        return this.base_menu_item;
      }else {
        return this.base_menu_item;
      }
    }
  }
}
</script>

<style lang='stylus'>
@import './App.styl'

.layout
  height 100%
  display flex
  flex-direction column
  
  .content
    position relative
    flex-grow 1
    min-height 10rem
    .drawer
      @extend .bg-vio-darkest
      color #fff
      height 100%
      overflow hidden
      .drawer-header
        cursor pointer
        &:hover
          @extend .bg-vio-dark

</style>