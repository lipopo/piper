<template lang='pug'>
div.config-page
  Card.config-card
    div.header.p-sm-5
      div
        span  Personal Config Center
      div
        Icon(v-if='loading' iconName='refresh' fontColor='#555' :spin='loading')
    div.split
    div.p-sm-5.control
      div.bg-success-default(@click='save_config' :class='btn') 
        span.g-sm-5 Save
        Icon(v-if='saving' iconName='refresh' fontColor='#fff' :spin='saving')
</template>

<script lang='coffee'>
import Icon from '../assets/icon/Icon.vue'

import Card from '../components/card/Card.vue'

App =
  name: 'ConfigPage'

  components: {
      Card,
      Icon
  }

  data: ->
    loading: true
    saving: false 
    user_name: ''

  methods:
    save_config: ->
      @saving = true
    
  computed:
    btn: ->
      btn_cls_map = ['button']
      if @saving
        btn_cls_map.push 'button-disable'
      return btn_cls_map.join(" ")

export default App
</script>

<style lang='stylus'>
@import '../assets/core/index.styl'


.config-page
  .config-card
    @extend .b-gray-light
    border-width 1px
    border-style solid
    width 50vw
    margin auto
    display flex
    flex-direction column

    .header
      font-weight bold
      color #555
      display flex
      justify-content space-between

    .split
      @extend .b-gray-default
      border-bottom-width 1px
      border-bottom-style solid
    
    .control
      display flex
      justify-content flex-end

    .button-disable
      filter opacity(70%)
      cursor not-allowed !important

      &:hover
        filter opacity(70%)
    

    .button
      @extend .inline-block
      @extend .p-sm-5
      @extend .s-smell
      color #fff
      cursor pointer
      user-select none

      &:hover
        @extend .bg-success-light
</style>