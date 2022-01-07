module.exports = {
    mode: 'production',
    entry:{
        index: './index.js'
    },
    output:{
    publicPath: './',
        filename: '[name].min.js',
    library: 'logfv-web-vue',
    libraryTarget: 'umd'
},
module:{
    rules:[{
        test:/\.worker\.js$/,
        use:{
            loader:'worker-loader',
            options:{
                inline: "fallback"
            }
        }
    }, {
        test: /\.js$/,
        use: {
            loader: 'babel-loader',
            options: {
                presets: [['@babel/preset-env', {
                    corejs: "3",
                    useBuiltIns: 'usage'
                }]]
            }
        },
        exclude: [/node_modules/,/\.worker\.js$/]
    }]
}
}
