

class Element
  # Element 代表了抽象的piper
  # 具有的属性 包含
  # - Idx 唯一指定id
  # - Name 命名
  # - Type 类型
  # - MetaInfo 元信息
  # - TargetPipe 目标元素
  constructor: (@idx, @name, @type, @meta_info)->
    @target_element = []

  link_to: (target_element) ->
    @target_element = [...@target_element, target_element]


export default Element