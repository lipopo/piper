<template lang="pug">
div.layout
  div.nav
    Navigator(title='Piper' :version='version')
      Icon(
        v-if='loading'
        iconName='refresh'
        fontColor='#fff'
        :spin='true'
      )
  div.content
    Drawer.drawer(:open='drawer_open')
      div.drawer-header.p-sm-5(slot='header' @click='open_drawer')
        div.inline-block(:class='drawer_open ? "" : "r-Z-180"') -)
      Menu(
        :fontColor='"#fff"'
        :menuBgColor='Color.vio.darkest'
        :itemActiveColor='Color.vio.default'
        :itemHoverColor='Color.vio.dark'
        :items='menu_item'
        @activeItem='activePage'
      )
    div.com-content.p-sm-5(
      :style="{width: `calc(100% - ${!drawer_open ? '2rem' : '10rem'})`}")
      div.flash-area
        Flash.g-sm-5-b(
          v-for='item, idx in flash_list'
          :type='item.type'
          :iconName='item.iconName'
          :content='item.content'
          @close='(idx) => close_flash(idx)'
        )
      keep-alive
        component(:is='content')
</template>

<script>
import { version } from './lib/index.coffee';
import AppCls from './app.coffee';

import Color from './assets/core/color.js';
import Icon from './assets/icon/Icon.vue';

import Drawer from './components/drawer/Drawer.vue';
import FlashE from './components/flash/flash.coffee';
import Flash from './components/flash/Flash.vue';
import Menu from './components/menu/Menu.vue';
import Navigator from './components/navigator/Navigator.vue';

import { 
  FlowPage,
  FlowBuilderPage,
  ConfigPage } from './page';

export default {
  components: {
    Navigator,
    Drawer,
    Menu,
    Icon,
    FlowBuilderPage,
    FlowPage,
    ConfigPage,
    Flash
  },
  data() {
    return {
      version: version,
      drawer_open: false,
      content: 'flow-page',
      base_menu_item: [
        {name: 'Flow', icon:'random', icls: 'r-Z-90', page: 'flow-page'}
        // {name: 'Config', icon: 'cog', page: 'config-page'}
      ],
      Color: Color,
      flash_list: [],
      loading: false,
      app: new AppCls()
    }
  },
  mounted: function() {
    let flash = new FlashE();
    // 绑定闪念事件
    flash.onflash(this.push_flash);
    // 绑定加载事件
    this.app.onloading(this.set_loading);
    this.app.onloaded(this.set_loaded);
  },
  methods: {
    open_drawer: function() {
      this.drawer_open = !this.drawer_open;
    },
    activePage: function(pageIdx) {
      this.content = this.base_menu_item[pageIdx].page
    },
    push_flash: function(item) {
      this.flash_list.push(item);
    },
    close_flash: function(idx) {
      this.flash_list.splice(idx, 1);
    },
    set_loading: function() {
      this.loading = true;
    },
    set_loaded: function() {
      this.loading = false;
    }
  },
  computed: {
    menu_item: function() {
      if(this.drawer_open) {
        return this.base_menu_item;
      }else {
        return this.base_menu_item.map( (item) => {
          return {
            icon: item.icon,
            icls: item.icls
          };
        });
      }
    }
  }
}
</script>

<style lang='stylus'>
@import './app.styl'

.layout
  height 100%
  display flex
  flex-direction column
  
  .content
    position relative
    flex-grow 1
    min-height 100rem
    .drawer
      @extend .bg-vio-darkest
      color #fff
      height 100%
      overflow hidden
      .drawer-header
        cursor pointer
        &:hover
          @extend .bg-vio-dark
    .com-content
      width calc(100% - 2rem)

</style>