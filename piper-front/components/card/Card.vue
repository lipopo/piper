<template lang='pug'>
div.card
  slot
</template>

<style lang='stylus'>
@import '../../assets/core/depth.styl'
@import '../../assets/core/layout.styl'

.card
  @extend .p-sm-5
  @extend .d1-c0

  &:hover
    @extend .d2-c0

</style>