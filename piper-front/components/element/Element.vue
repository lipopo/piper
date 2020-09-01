<template lang='pug'>
div.element(ref='ele')
  div.element-header(:class="element_style")
    div.element-header-content(@click="change_status") {{ type ? `${idx} : ${name} (${type})` : name}}
    slot(name='append') 
  div.sub-items(:style="{display: active ? 'block' : 'none'}")
    div.element-name
      input(v-model="name" @input="change_name" @change="change_name")
    div.element-type
      select(v-model="type" @input="change_type" @change="change_type")
        template(v-for="option in element_options")
          option(:key="`${name}-${option}`") {{ option }}
    div.meta-info
      input(v-model="meta_info")
</template>

<script lang='coffee'>
import { element_options } from '../../lib/index.coffee'

App = 
  props:
    idx:
      type: Number
      required: true

    element:
      type: Object
      required: true

  data: ->
    active: false # element的状态
    name: null
    type: null
    meta_info: {}
    element_options: element_options

  computed:
    element_style: ->
      if @active
        'bg-info-light'
      else
        'bg-info-dark'
  
  mounted: ->
    @update_element()
  
  watch:
    element: () ->
      @update_element()
    
    idx: () ->
      @update_element()

  methods:
    update_element: ->
      @name = @element.name
      @type = @element.type
      @meta_info = JSON.stringify @element.meta_info

    change_name: (e) ->
      @element.name = @name_ = e.target.value
    
    change_type: (e) ->
      @element.type = @type_ = e.target.value
    
    change_meta_info: (e) ->
      @meta_info_ = e.target.value
      @elemnt.meta_info = JSON.parse @meta_info
    
    change_status: (e) ->
      @active = !@active
    
export default App
</script>

<style lang="stylus">
@import '../../assets/core/color.styl'

.element
  @extend .b-info-darkest
  border-width 1px
  border-style solid
  display flex
  flex-direction column
  align-items center
  justify-content flex-start
  position relative
  
  .element-header
    color #fff
    cursor pointer

    display flex
    align-items center

  .sub-items
    padding 15px

    div:nth-child(n)
      @extend .b-info-darkest
      border-bottom-width 1px
      border-bottom-style solid

    div:last-child
      border-bottom-style none

  div
    width 100%
    padding 10px

    input 
      width 100%
      padding 5px

    select 
      width 100%
      padding 5px
</style>