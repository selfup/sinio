const path = require('path');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const BabiliPlugin = require('babili-webpack-plugin');

const plugins = [
  new ExtractTextPlugin({
    filename: './bundle.css',
    allChunks: true,
  }),
];

module.exports = function webpackStuff(env) {
  if (env === 'production') plugins.push(new BabiliPlugin());

  return {
    entry: [
      './front_end/src/index.js',
      './front_end/src/home/index.js',
      './front_end/styles/app.css',
    ],
    output: {
      filename: 'bundle.js',
      path: path.resolve(__dirname, './public/prod/'),
    },
    module: {
      rules: [{
        test: /\.js$/,
        loader: 'babel-loader',
        query: {
          presets: [
            'es2015',
          ],
          plugins: [],
        },
        include: [
          path.resolve(__dirname, './front_end'),
        ],
      }, {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          use: 'css-loader?importLoaders=1',
        }),
      }],
    },
    plugins,
  };
};
