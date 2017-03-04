var webpack = require('webpack');

module.exports = {
  entry: './react_minesweeper.jsx',
  devtool: 'inline-source-map',
  module: {
    loaders: [
      {
        test: [/\.jsx?$/, /\.js?$/], // Specifies file types to transpile
        exclude: /(node_modules)/, // Leaves dependencies alone
        loader: 'babel-loader', // Sets Babel as the transpiler
        query: {
          presets: ['es2015', 'react'] // Tells Babel what syntaxes to translate
        }
      }
    ]
  },
  devtool: 'source-map',
  output: {
    filename: './bundle.js'
  },
  resolve: {
    extensions: ['.jsx', '.js']
  }
}
