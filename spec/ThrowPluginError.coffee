{expect} = require 'chai'
gutil = require 'gulp-util'
noflo = require 'noflo'
sinon = require 'sinon'
ThrowPluginError = require '../components/ThrowPluginError'


describe 'ThrowPluginError', ->

  component = null
  options = null


  beforeEach ->
    component = ThrowPluginError.getComponent()

    options = noflo.internalSocket.createSocket()
    component.inPorts.options.attach options


  describe 'options', ->

    it 'should be required', ->
      required = component.inPorts.options.isRequired()
      expect(required).to.be.true

    it 'should be an object', ->
      dataType = component.inPorts.options.getDataType()
      expect(dataType).to.equal 'object'


    context 'when sent', ->

      it 'should be passed to a new instance of gutil.PluginError', ->
        stub = sinon.stub gutil, 'PluginError'

        optionsPacket = { plugin: 'test', message: 'test message' }
        try options.send optionsPacket

        expect(stub.calledOnce).to.be.true
        expect(stub.calledWithNew()).to.be.true
        expect(stub.firstCall.args[0]).to.equal optionsPacket

        stub.restore()

      it 'should throw an error', (done) ->
        stub = sinon.stub gutil, 'PluginError'
        optionsPacket = { plugin: 'test', message: 'test message' }

        try
          options.send optionsPacket
        catch e
          expect(e).to.be.instanceof gutil.PluginError
          done()

        stub.restore()
