/**
 * Create by pengweikang on 2018/4/4.
 */
//const path = [];
const path = require('path')
module.exports = [{
    entry: './app/indexBpmn.js', // 入口文件
    output: {
        path: path.resolve(__dirname, 'build'), // 必须使用绝对地址,输出文件夹
        filename: "bundle.js", // 打包后输出文件的文件名
        publicPath: '/build/'
    },
    mode: 'development',
    module: {
        rules: [
            {test: /\.css$/, loader: 'style-loader!css-loader'},
            {test: /\.(png|jpg|gif)$/, loader: 'url-loader?limit=8192'},
            {test: /\.svg/, loader: 'svg-url-loader'},
            {
                test: /\.(eot|woff|ttf)$/,
                loader: "file-loader",
                options:{
                    outputPath:"/font/"
                }
            }
        ]
    }
}]