module.exports = {
  lintOnSave: undefined,
  productionSourceMap: true,
  publicPath: './',
  chainWebpack: (config) => {
    config.module
        .rule("worker")
        .test(/\.worker\.js$/)
        .use("worker-loader")
        .loader("worker-loader")
        .options({
          inline: "fallback"
        });
    config.module.rule("js").exclude.add(/\.worker\.js$/);
  },
  devServer: {
    port: 8080,
    compress: true,
    disableHostCheck: true
  }
}
