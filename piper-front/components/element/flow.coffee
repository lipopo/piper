"""
Flow

抽象的流，用于控制整体的流的概念。主要功能有负责向元素树上
挂载/拆卸元素节点，构建和管理元素间链接。
"""
class Flow
  constructor: () ->
    @flow_tree = {}
  
  add: (element) ->
    @flow_tree[element.idx] =
      element: element
      target_elements: []
      source_elements: []

  check_idx: (element) ->
    if element.idx == null
      # XXX: Math库的通用性
      element.idx = Math.max(...Object.keys(@flow_tree)) + 1
  
  link: (source_element, element) ->
    # 元素间链接构建
    @check_idx source_element
    @check_idx element
    # 向源元素中填充目标元素
    if @flow_tree[source_element.idx]
      @flow_tree[source_element.idx].target_elements.push element
    else
      @flow_tree[source_element.idx] =
        element: source_element
        # 来源元素
        source_elements: []
        # 目标元素
        target_elements: [element]

    # 向目标元素中添加源元素
    if @flow_tree[element.idx]
      @flow_tree[element.idx].source_elements.push source_element
    else
      @flow_tree[element.idx] =
        element: element
        source_elements: [source_element]
        target_elements: []

  dislink: (source, target) ->
    # 元素间链接删除
    idx = @flow_tree[source.idx].target_elements.indexOf target
    target_idx = @flow_tree[target.idx].source_elements.indexOf source
  
    if idx >= 0
      # clear source element
      @flow_tree[source.idx].target_elements.splice idx, 1
    
    if target_idx >= 0
      # clear target idx
      @flow_tree[target.idx].source_elements.splice target_idx, 1

  dispatch: (element) ->
    self = this
    # 元素删除
    if @flow_tree[element.idx].target_elements.length > 0
      # 清理下游链接
      target_elements = [...@flow_tree[element.idx].target_elements]
      target_elements.forEach (ele) -> self.dislink element, ele
    
    if @flow_tree[element.idx].source_elements.length > 0
      # 清理上游链接
      source_elements = [...@flow_tree[element.idx].source_elements]
      source_elements.forEach (ele) -> self.dislink ele, element

    if @flow_tree[element.idx]
      # 拆卸本元素
      @dispatch_element element
    else
      false

  dispatch_element: (element) ->
    # 在目标元素拆卸单个元素
    delete @flow_tree[element.idx]
    if Object.keys(@flow_tree).length > 0
      return false
    else
      return true


export default Flow;