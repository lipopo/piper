const coffee = require('coffeescript');
const babelJest = require('babel-jest');


module.exports = {
  // CoffeeScript files can be .coffee or .litcoffee
  process: function(src, path, ...rest) {
    if (coffee.helpers.isCoffee(path)) {
      _el =  coffee.compile(src, {
        bare: true,
        literate: coffee.helpers.isLiterate(path)
      });

      return babelJest.process(_el, path, ...rest);
    }
    return src;
  }
};