<template lang="pug">
Navigator(title='Piper')
</template>

<script>
import { version } from './lib/index.coffee';
import Button from './components/button/Button.vue';
import Navigator from './components/navigator/Navigator.vue';

export default {
  components: {
    Button,
    Navigator
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