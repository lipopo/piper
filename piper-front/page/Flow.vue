<template lang='pug'>
.flow-page
  .section
    search-bar(placeholder='Please enter flow name or keyword' @search='search_flow')
  
  .section.trending-section(v-if='!searching')
    .section-header
      .section-title
        Icon.g-sm-5(iconName='fire' fontColor='#555')
        span Trending
    .p-sm-5
      Card.section-content.card-container
        Carousel(
          @prev='() => {}'
          @nex='() => {}'
        )
          template
            trending-card(
              flowName='d'
              :style='{width: "12rem"}'
            )
  
  .section.my-flow-section(v-if='!searching')
    .section-header
      .section-title

        Icon.r-Z-90.g-sm-5(iconName='random' fontColor='#555')
        span My Flow
    
    .section-content

      Card.item-card(v-for='my_item in my_flow_items')
        div(v-html='my_item.content')

      Card.item-card.crete-card
        div(@click='open_item')
          Icon(iconName='plus' fontColor='#555')

  Card.section.search-section(v-if='searching')

    div.control-row
      div.close-icon(@click='close_search')
        Icon(iconName='times' fontColor='#555')

    div.search-no-data(v-if='search_items.length === 0')
      span There is no data about info
    
</template>

<script lang='coffee'>
import Icon from '../assets/icon/Icon.vue'
import Card from '../components/card/Card.vue'
import TrendingCard from '../components/card/TrendingCard.vue'
import Carousel from '../components/carousel/Carousel.vue'
import SearchBar from '../components/search-bar/SearchBar.vue'

import AppE from '../app.coffee'
import Flow from './flow.coffee'

App = 
  name: 'Flow'
  
  components: {
    Card,
    Carousel,
    SearchBar,
    TrendingCard,
    Icon
  }

  data: ->
    app: new AppE()
    flow: new Flow()
    searching: false 
    trending_items: []
    my_flow_items: []
    search_items: []

  mounted: ->
    trending_items = await @flow.load_trending_data()
    my_flow_items = await @flow.load_my_flow_data()

  methods:
    search_flow: (val)->
      @app.loading()
      @flow.search_flow val
      @app.loaded()
      @searching = true
    
    close_search: ->
      @search_items = []
      @searching = false
    
    open_item: (idx) ->
      # 打开需要构建的项目

export default App
</script>

<style lang='stylus'>
@import '../assets/core/index.styl'

.flow-page
  .section
    @extend .p-sm-5

    .section-header
      .section-title
        font-weight bold

    .section-content
      @extend .p-sm-5
      display flex
      align-items center
      flex-wrap wrap

      .item-card
        @extend .p-sm-5
        @extend .b-gray-light
        @extend .g-sm-5
        @extend .g-sm-5-b

        border-width 1px
        border-style solid

        width 15rem
        height 15rem
        
        cursor pointer

        display flex
        align-items center
        justify-content center

        &:hover
          @extend .b-gray-default
          border-style dashed
      
      .create-card
        font-size 4rem

  .trending-section
    display flex
    flex-direction column

  .card-container
    @extend .b-gray-light
    border-width 1px
    border-style solid

  .search-section
    @extend .b-gray-light
    border-width 1px
    border-style solid

    .control-row
      display flex
      justify-content flex-end

      .close-icon
        cursor pointer
    
    .search-no-data
      @extend .c-gray-default
      font-size 1.2em
      display flex
      justify-content center
      

</style>