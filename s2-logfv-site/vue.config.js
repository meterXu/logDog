const namespace = "logfvSite"
const CopyPlugin  = require('copy-webpack-plugin');
const s2Conf = require('./s2.config.json')
const fs = require('fs')
module.exports = {
  lintOnSave: undefined,
  productionSourceMap: false,
  css: {
    extract: false
  },
  configureWebpack:  config => {
    config.entry = {
      [namespace]: ["./src/main.js"]
    }
      if (process.env.NODE_ENV === 'production') {
          config.optimization.runtimeChunk = false
          config.optimization.splitChunks = {
              chunks: 'all',
              maxSize: 102400,
              maxAsyncRequests: 5,
              maxInitialRequests: 3,
              cacheGroups: {
                  default: false
              }
          }
      }
    return {
      output: {
        library: namespace,
        filename: process.env.NODE_ENV === 'production'
          ? `biz/${namespace}/js/[id].[contenthash:4].js`
          : '[id].js' ,
        chunkFilename: `biz/${namespace}/js/${namespace}.vendors.[contenthash:4].js`,
      },
      plugins:[
        new CopyPlugin({patterns:
          [{
            from: './src/project.js', to: `biz/${namespace}/js/project.[contenthash:4].js`,
            transform:(res,p)=>{
              res = res.toString().replace(/export default project_.*/,'')
              return res
            }
          }]
        })
      ]
    }
  },
  chainWebpack:config=>{
    config.module
      .rule("images")
      .use("url-loader")
      .tap(options => {
        options.name = `biz/${namespace}/img/[name].[ext]`;
        options.fallback = {
          loader: "file-loader",
          options: {
            name: `biz/${namespace}/img/[name].[ext]`
          }
        };
        return options;
      });
    const svgRule = config.module.rule('svg')
    svgRule
        .use('file-loader')
        .tap(options => {
          options.name = `biz/${namespace}/img/[name].[hash:8].[ext]`;
          options.fallback = {
            loader: "file-loader",
            options: {
              name: `biz/${namespace}/img/[name].[hash:8].[ext]`
            }
          };
          return options;
        })
    const fontRule = config.module.rule('fonts')
    fontRule
        .use('url-loader')
        .tap(options => {
          options.name = `biz/${namespace}/fonts/[name].[hash:8].[ext]`;
          options.fallback = {
            loader: "file-loader",
            options: {
              name: `biz/${namespace}/fonts/[name].[hash:8].[ext]`
            }
          };
          return options;
        })
    const mediaRule = config.module.rule('media')
    mediaRule
        .use('url-loader')
        .tap(options => {
          options.name = `biz/${namespace}/media/[name].[hash:8].[ext]`;
          options.fallback = {
            loader: "file-loader",
            options: {
              name: `biz/${namespace}/media/[name].[hash:8].[ext]`
            }
          };
          return options;
        })
  },
  devServer: {
    port: 8081,
    onListening: function (server) {
      const port = server.listeningApp.address().port;
      s2Conf[namespace].js[0] = s2Conf[namespace].js[0].replace(/(?<=:)\d+/g,port)
      s2Conf['host']=`http://localhost:${port}`
      fs.writeFileSync('./public/s2.config.json',JSON.stringify(s2Conf))
    },
  }
}
