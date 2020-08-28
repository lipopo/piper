"""
Flow

抽象的流，用于控制整体的流的概念。主要功能有负责向元素树上
挂载/拆卸元素节点。
"""


class Flow
  constructor: ->
    # 起点元素
    @entry_point = null

    # 流的树
    @flow_tree = {}

  add_element: (source_element, element) ->

    # 向源元素中填充目标元素
    if @flow_tree[source_element]
      @flow_tree[source_element].target_elements.push element
    else
      @flow_tree[source_element] = {
          # 来源元素
          source_elements: [],
          # 目标元素
          target_elements: [element]
      }   

    # 向目标元素中添加源元素
    if @flow_tree[element]
      @flow_tree[element].source_elements.push source_element
    else
      @flow_tree[element] = {
          source_elements: [source_element],
          target_elements: []
      }
  clear_ele: (source, target) ->
    idx = @flow_tree[source].target_elements.indexOf target
    if idx >= 0
      # clear element
      @flow_tree[source].target_elements.splice idx, 1

  dispatch: (element) ->
    dispatch = @dispatch
    clear = @clear_ele
    if @flow_tree[element].target_elements.length > 0
      # 拆卸子元素
      @flow_tree[element].target_elements.forEach (ele) -> dispatch(ele)
    
    if @flow_tree[element].source_elements.length > 0
      # 清理父级别元素target
      @flow_tree[element].source_elements.forEach (ele) -> clear(ele)

    if @flow_tree[element]
      # 拆卸本元素
      @dispatch_element element

  dispatch_element: (element) ->
    # 在目标元素拆卸单个元素
    delete @flow_tree[element]


export default Flow