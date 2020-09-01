import Flow from './flow.coffee'

setup_flow = ->
  entry_ele = 
    idx: 0
    name: 'entry'
  flow = new Flow entry_ele
  [entry_ele, flow]

test 'Setup Flow', ->
  ele = 'entry'
  flow = new Flow ele
  expect(flow.entry_point).not.toBe undefined
  expect(flow.flow_tree).not.toBe undefined

test 'Flow - Clear Element', ->
  [entry_ele, flow] = setup_flow()
  new_ele = 
    idx: 1
    name: 'new_ele'
  # add first
  flow.link entry_ele, new_ele
  expect(flow.flow_tree[entry_ele.idx].target_elements).toContain new_ele
  # clear
  flow.dislink entry_ele, new_ele
  expect(flow.flow_tree[entry_ele.idx].target_elements).not.toContain new_ele

test 'Flow - dispatch Signal Element', ->
  [entry_ele, flow] = setup_flow()
  expect(flow.flow_tree[entry_ele.idx]).toBeDefined()
  flow.dispatch_element entry_ele
  expect(flow.flow_tree[entry_ele.idx]).not.toBeDefined()

test 'Flow - dispatch Element', ->
  [entry_ele, flow] = setup_flow()

  # create element
  ele1 = 
    idx: 2
    name: 'ele1'

  ele2 = 
    idx: 3
    name: 'ele2'

  ele3 = 
    idx: 4
    name: 'ele3'

  # build flow
  flow.link entry_ele, ele1
  flow.link ele1, ele2
  flow.link ele1, ele3

  expect(flow.flow_tree[entry_ele.idx].target_elements).toContain ele1
  expect(flow.flow_tree[ele1.idx].target_elements).toContain ele2
  expect(flow.flow_tree[ele1.idx].target_elements).toContain ele3
  expect(flow.flow_tree[ele2.idx] == undefined).toBeFalsy()
  expect(flow.flow_tree[ele3.idx] == undefined).toBeFalsy()

  # dispatch element1
  flow.dispatch(ele1)

  expect(flow.flow_tree[ele1.idx] == undefined).toBeTruthy()
  expect(flow.flow_tree[ele2.idx].source_elements).not.toContain ele1
  expect(flow.flow_tree[ele3.idx].source_elements).not.toContain ele1

test 'Flow - link Elements', ->
  [entry_ele, flow] = setup_flow()

  new_ele =
    idx: 1
    name: 'new_ele'

  unknow_ele = 
    idx: 2
    name: 'unknow_ele'

  flow.link entry_ele, new_ele

  expect(flow.flow_tree[entry_ele.idx].target_elements).toContain new_ele
  expect(flow.flow_tree[new_ele.idx].source_elements).toContain entry_ele

  # link with no source
  expect(flow.flow_tree[unknow_ele.idx] == undefined).toBeTruthy()
  flow.link unknow_ele, new_ele
  expect(flow.flow_tree[unknow_ele.idx]).toBeDefined()

  expect(flow.flow_tree[unknow_ele.idx].target_elements).toContain new_ele
  expect(flow.flow_tree[new_ele.idx].source_elements).toContain unknow_ele

test 'Flow - Check Idx', ->
  [entry_ele, flow] = setup_flow()

  add1_ele =
    idx: 1
    name: 'add_1'
  
  add2_ele = 
    idx: null
    name: 'add_2'

  flow.link entry_ele, add1_ele
  flow.link add1_ele, add2_ele

  expect(add2_ele.idx).toBe 2
  