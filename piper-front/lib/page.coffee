class Page

  register: (pageName, pageComponents) ->
    # 页面注册
    _globalScope = null
    if window
      _globalScope = window
    
      if _globalScope == null
        _globalScope = {}
      _globalScope.page_map[pageName] = pageComponents
    else
      return null
    

  goto: (pageName, { options }) ->
    # 页面跳转
    _globalScope.page_map['_current_page'] = pageName


export default Page