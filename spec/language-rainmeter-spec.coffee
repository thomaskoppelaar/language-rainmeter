ed = require 'atom'
fs = require 'fs'
path = require 'path'

describe 'language-rainmeter', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-rainmeter')

    runs ->
      grammar = atom.grammars.grammarForScopeName('source.rainmeter')

  it 'parses the grammar', ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe 'source.rainmeter'

  it 'tokenizes metadata headers', ->
    {tokens} = grammar.tokenizeLine('[Rainmeter]')
    expect(tokens[0]).toEqual value: '[Rainmeter]', scopes: ['source.rainmeter', 'predefined.section.rainmeter']

    {tokens} = grammar.tokenizeLine('[Metadata]')
    expect(tokens[0]).toEqual value: '[Metadata]', scopes: ['source.rainmeter', 'predefined.section.rainmeter']

    {tokens} = grammar.tokenizeLine('[Variables]')
    expect(tokens[0]).toEqual value: '[Variables]', scopes: ['source.rainmeter', 'predefined.section.rainmeter']

  # TODO: Get this working, scopes arent detected
  it 'tokenize general options', ->
    {tokens} = grammar.tokenizeLine('Meter=Image')
    expect(tokens[0]).toEqual value: 'Meter', scopes: ['source.rainmeter',
     'option.rainmeter']
    expect(tokens[2]).toEqual value: 'Image', scopes: ['source.rainmeter',
     'value.constant.important.rainmeter']
