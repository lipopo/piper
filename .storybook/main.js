module.exports = {
    stories: [
        '../piper-front/**/*.stories.mdx'
    ],
    addons: [
        '@storybook/addon-docs'
    ],
    webpackFinal: async (config, { configType }) => {

        config.module.rules = [ 
            ...config.module.rules,
            ...[
                {
                    test: /\.pug$/,
                    oneOf: [
                        {
                            resourceQuery: /^\?vue/,
                            use: ['pug-plain-loader']
                        },
                        {
                            use: ['raw-loader', 'pug-plain-loader']
                        }
                    ]
                },
                {
                    test: /\.(styl|stylus)$/,
                    oneOf: [
                        {
                            resourceQuery: /^\?vue/,
                            use: [
                                'style-loader',
                                'css-loader',
                                'stylus-loader'
                            ]
                        },
                        {
                            use: [
                                'style-loader',
                                'css-loader',
                                'stylus-loader'
                            ]
                        }
                    ]
                },
                {
                    test: /\.coffee(script)?$/,
                    use: 'coffee-loader'
                }
            ]
        ];
        return config;
    }
};