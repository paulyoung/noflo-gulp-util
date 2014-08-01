{expect} = require 'chai'
gutil = require 'gulp-util'
noflo = require 'noflo'
sinon = require 'sinon'
LogMessage = require '../components/LogMessage'


describe 'LogMessage', ->

  component = null
  message = null


  beforeEach ->
    component = LogMessage.getComponent()

    message = noflo.internalSocket.createSocket()
    component.inPorts.message.attach message


  describe 'message', ->

    it 'should be required', ->
      required = component.inPorts.message.isRequired()
      expect(required).to.be.true

    it 'should be a string', ->
      dataType = component.inPorts.message.getDataType()
      expect(dataType).to.equal 'string'


    context 'when sent', ->

      it 'should be passed to gutil.log', ->
        stub = sinon.stub gutil, 'log'

        messagePacket = 'Test'
        message.send messagePacket

        expect(stub.calledOnce).to.be.true
        expect(stub.firstCall.args[0]).to.equal messagePacket

        stub.restore()
