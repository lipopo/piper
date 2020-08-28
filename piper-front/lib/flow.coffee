"""
Flow

抽象的流，用于控制整体的流的概念。主要功能有负责向元素树上
挂载/拆卸元素节点。
"""


class Flow

  constructor: (@entry_point) ->
    @flow_tree = {}
    @flow_tree[@entry_point.idx] =
      source_elements: []
      target_elements: []

  link: (source_element, element) ->
    # 向源元素中填充目标元素
    if @flow_tree[source_element.idx]
      @flow_tree[source_element.idx].target_elements.push element
    else
      @flow_tree[source_element.idx] = {
          # 来源元素
          source_elements: [],
          # 目标元素
          target_elements: [element]
      }   

    # 向目标元素中添加源元素
    if @flow_tree[element.idx]
      @flow_tree[element.idx].source_elements.push source_element
    else
      @flow_tree[element.idx] = {
          source_elements: [source_element],
          target_elements: []
      }

  dislink: (source, target) ->
    idx = @flow_tree[source.idx].target_elements.indexOf target
    console.log @flow_tree, idx
    if idx >= 0
      # clear element
      @flow_tree[source.idx].target_elements.splice idx, 1

  dispatch: (element) ->
    dispatch = @dispatch
    dislink = @dislink
    if @flow_tree[element.idx].target_elements.length > 0
      # 拆卸子元素
      @flow_tree[element.idx].target_elements.forEach(console.log)
    
    if @flow_tree[element.idx].source_elements.length > 0
      # 清理链接信息
      @flow_tree[element.idx].source_elements.forEach (ele) -> dislink ele, element
      @flow_tree[element.idx].source_elements = []

    if @flow_tree[element.idx]
      # 拆卸本元素
      @dispatch_element element

  dispatch_element: (element) ->
    # 在目标元素拆卸单个元素
    delete @flow_tree[element.idx]


export default Flow;