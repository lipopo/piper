<template lang='pug'>
div.menu-list
  template(v-for='item, i_idx in items')
    div.menu-item-i(
      :key='`${i_idx}`'
      @click='() => activeItem(i_idx)'
    )
      menu-item(
        :bgColor='menuBgColor'
        :active='i_idx === activeItemIdx'
        :bgActiveColor='itemActiveColor'
        :bgHoverColor='itemHoverColor'
        :fontColor='fontColor'
      )
        div(v-html='item.name')
      
</template>
<script lang='coffee'>
import MenuItem from './MenuItem.vue'

App = 
  name: 'Menu'

  components: { MenuItem }

  data: ->
    activeItemIdx: 0

  props:
    menuBgColor:
      type: String
      default: '#eee'
    
    itemActiveColor:
      type: String
      default: '#ddd'

    itemHoverColor:
      type: String
      default: '#ddd'
    
    items:
      type: Array
      default: -> []
    
    fontColor:
      type: String
      default: '#555'
  
  methods:
    activeItem: (idx) ->
      @activeItemIdx = idx
      @$emit 'active-item', idx
      

export default App
</script>

<style lang='stylus'>
.menu-list
  display flex
  flex-direction column
  justify-content flex-start
  align-items flex-start

  .menu-item-i
    width 100%

</style>