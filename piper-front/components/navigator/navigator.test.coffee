import Navigator from './navigator.coffee'


test "Naviagator", ->
  nav = new Navigator 'Brand', 'v1',  [{name: 'link', link: '#'}]

  expect(nav.title).toBe 'Brand'
  expect(nav.append).toBe 'Brand<span class="version">v1</span>'
  expect(nav.after).toBe '<li><a href="#">link</a></li>'