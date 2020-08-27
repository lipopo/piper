<template lang="pug">
div.container Piper {{ version }}
  Button Helo
</template>

<script>
import { version } from './lib/index.coffee';
import Button from './components/button/Button.vue';

export default {
  components: {
    Button
  },
  data() {
    return {
      version: version
    }
  }
}
</script>

<style lang='stylus'>
@import './App.styl'
</style>