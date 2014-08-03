{Component, InPorts} = require 'noflo'
gutil = require 'gulp-util'


class ThrowPluginError extends Component

  description: 'Equivalent to new gutil.PluginError'
  icon: 'warning'

  constructor: ->
    @inPorts = new InPorts
      options:
        datatype: 'object'
        description: 'The options parameter to be passed to new gutil.PluginError'
        required: true


    @inPorts.options.on 'data', (data) ->
      throw new gutil.PluginError data


module.exports =
  getComponent: -> new ThrowPluginError
