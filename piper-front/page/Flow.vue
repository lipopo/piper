<template lang='pug'>
.flow-page
  .section(v-if='!creating')
    search-bar(
      placeholder='Please enter flow name or keyword'
      @search='search_flow'
    )

  .section.trending-section(v-if='showing')
    .section-header
      .section-title
        Icon.g-sm-5(iconName='fire' fontColor='#555')
        span Trending

    .p-sm-5
      Card.section-content.card-container
        Carousel(
          @prev='trending_prev'
          @next='trending_next'
        )
          .trending-row
            .trending-scroll-row(:style='{left: `-${trending_left}%`}')
              template(v-for='trending_item in trending_items')
                trending-card(
                  :flowName='trending_item.name'
                  @install='install_flow'
                  :style='{minWidth: "20%"}'
                )

  .section.my-flow-section(v-if='showing')
    .section-header.g-sm-10-b
      .section-title
        Icon.r-Z-90.g-sm-5(iconName='random' fontColor='#555')
        span My Flow

    .section-content
      Card.item-card(v-for='item in my_flow_items')
        flow-card(:flowName='item.name' :imgPath='item.img' :updateTime='item.update')

      div(@click='create_flow')
        Card.item-card.create-card
          Icon(iconName='plus' fontColor='#555')

  Card.section.search-section(v-if='searching')
    .control-row
      .close-icon(@click='close_search')
        Icon(iconName='times' fontColor='#555')

    .search-no-data(v-if='search_items.length === 0')
      span There is no data about info

  .section.create-section(v-if='creating')
    .control-row
      .close-icon(@click='close_create')
        Icon(iconName='times' fontColor='#555')

    .create-panel
      flow-builder-page
</template>

<script lang='coffee'>
import Icon from '../assets/icon/Icon.vue'
import Card from '../components/card/Card.vue'
import FlowCard from '../components/card/FlowCard.vue'
import TrendingCard from '../components/card/TrendingCard.vue'
import Carousel from '../components/carousel/Carousel.vue'
import SearchBar from '../components/search-bar/SearchBar.vue'
import FlowBuilderPage from './FlowBuilder.vue'

import AppE from '../app.coffee'
import Flow from './flow.coffee'


App =
  name: 'Flow'

  components: {
    Card,
    Carousel,
    SearchBar,
    TrendingCard,
    Icon,
    FlowBuilderPage,
    FlowCard
  }

  data: ->
    app: new AppE()
    flow: new Flow()
    searching: false
    creating: false
    trending_idx: 0
    trending_items: []
    my_flow_items: []
    search_items: []

  mounted: ->
    @trending_items = await @flow.load_trending_data()
    @my_flow_items = await @flow.load_my_flow_data()
  
  computed:
    showing: ->
      !@creating && !@searching
    
    trending_left: ->
      @trending_idx * 20

  methods:
    search_flow: (val)->
      @app.loading()
      await @flow.search_flow val
      @app.loaded()
      @searching = true

    close_search: ->
      @search_items = []
      @searching = false

    create_flow: () ->
      # 创建流 FlowBuilder
      @creating = true

    close_create: ->
      @creating = false

    install_flow: () ->
      # 流安装

    open_item: (idx) ->
      # 打开需要构建的项目
    
    trending_prev: ->
      # goto prev item
      _trending_idx = @trending_idx
      _trending_idx -= 1
      @trending_idx = Math.max _trending_idx, 0
    
    trending_next: ->
      # goto next item
      _trending_idx = @trending_idx
      _trending_idx += 1
      @trending_idx = Math.min _trending_idx, @trending_items.length - 5

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

    .control-row
      display flex
      justify-content flex-end

      .close-icon
        cursor pointer

    .section-content
      @extend .p-sm-5
      display flex
      align-items center
      flex-wrap wrap

      .item-card
        @extend .b-gray-light
        @extend .g-sm-5
        @extend .g-sm-5-b

        padding 0
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
    
    .trending-row
      .trending-scroll-row
        display flex
        flex-direction row
        position relative
        transition .5s
        transition-timing-function ease-in-out

  .card-container
    @extend .b-gray-light
    border-width 1px
    border-style solid

  .search-section
    @extend .b-gray-light
    border-width 1px
    border-style solid

    .search-no-data
      @extend .c-gray-default
      font-size 1.2em
      display flex
      justify-content center
</style>