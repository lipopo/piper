const coffee = require('coffeescript');
const babelJest = require('babel-jest');


module.exports = {
    process: (src, path, ...rest) => {
        console.log(src, path)
        if (coffee.helpers.isCoffee(path)) {
            // Compile the CoffeeScript files to JSX
            compiled_to_js = coffee.compile(src, {bare: true});
            return babelJest.process(compiled_to_js, path, ...rest);
        }
        return src;
    }
};