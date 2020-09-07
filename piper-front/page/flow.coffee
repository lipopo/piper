import { trending_data, my_flow_data } from '../assets/mock-data/mock-data.json'


class Flow
  load_trending_data: ->
    # 加载流程的flow
    trending_data
    
  load_my_flow_data: ->
    # 加载私有的flow流文件
    my_flow_data

  search_flow: (val) ->
    # 按照字符搜索流的信息


export default Flow