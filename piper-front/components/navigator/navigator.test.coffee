import Navigator from './navigator.coffee'


test "Naviagator", ->
  nav = new Navigator 'Brand', [{name: 'link', link: '#'}]

  expect(nav.title).toBe 'Brand'
  expect(nav.append).toBe 'Brand'
  expect(nav.after).toBe '<li><a href="#">link</a></li>'