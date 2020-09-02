<template lang='pug'>
div.border-box
  div.border-row
    border-cell.cell(:borders='tl_cell')
    border-cell.cell(:borders='tr_cell')
  div.border-row
    border-cell.cell(:borders='bl_cell')
    border-cell.cell(:borders='br_cell')
</template>

<script lang='coffee'>
import BorderCell from './BorderCell.vue'

App = 
  components: {
    BorderCell
  }

  props:
    type:
      type: Array
      default: () => []

  computed:
    bl_cell: ->
      @type.map(
        (tp) ->
          re = switch tp
            when 1 then 'bottom'
            when 8 then 'left'
            when 9 then 'right'
            when 12 then 'top'
            else false
          return re
      ).filter(
        (val) -> val
      )

    br_cell: ->
      @type.map(
        (tp) ->
          switch tp
            when 2 then 'bottom'
            when 3 then 'right'
            when 10 then 'top'
            else false
      ).filter(
        (val) -> val
      )

    tr_cell: ->
      @type.map(
        (tp) ->
          switch tp
            when 4 then 'right'
            when 5 then 'top'
            else false
      ).filter(
        (val) -> val
      )

    tl_cell: ->
      @type.map(
        (tp) ->
          switch tp
            when 7 then 'left'
            when 11 then 'right'
            when 6 then 'top'
            else false
      ).filter(
        (val) -> val
      )

export default App
</script>

<style lang='stylus'>
.border-box
  display flex
  flex-direction column
  align-items stretch
  justify-content flex-start
  border-color inherit

  .border-row
    display flex
    height 50%
    flex-direction row
    align-items stretch
    justify-content flex-start
    border-color inherit

    .cell
      height 100%
      width 50%
      border-color inherit
</style>