{Component, InPorts} = require 'noflo'
gutil = require 'gulp-util'


class LogMessage extends Component

  description: 'Equivalent to gutil.log'
  icon: 'terminal'

  constructor: ->
    @inPorts = new InPorts
      message:
        datatype: 'string'
        description: 'The message to be logged'
        required: true


    @inPorts.message.on 'data', (data) ->
      gutil.log data


module.exports =
  getComponent: -> new LogMessage
