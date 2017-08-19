# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"


atom.commands.add 'atom-text-editor', 'placeRuler': (event) ->
  return unless _editor = atom.workspace.getActiveTextEditor()
  return if _editor.getPath() == undefined
  return if _editor.getPath().endsWith('.txt')
  _position = _editor.getCursorScreenPosition()
  atom.config.set('editor.preferredLineLength', _position.column)
  f = () ->
    atom.config.set('editor.preferredLineLength', 800)
  setTimeout f, 1000
  event.abortKeyBinding()

atom.commands.add 'atom-text-editor', 'hideRuler': (event) ->
  return unless _editor = atom.workspace.getActiveTextEditor()
  atom.config.set('editor.preferredLineLength', 800)
  event.abortKeyBinding()

atom.getCurrentWindow().on 'blur', ->
  atom.config.set('editor.preferredLineLength', 800)

atom.commands.add 'atom-text-editor', 'showScope': (event) ->
  return unless _editor = atom.workspace.getActiveTextEditor()
  scopes = _editor.scopeDescriptorForBufferPosition(_editor.getCursorBufferPosition()).getScopesArray()
  atom.notifications.addInfo(scopes.join(' → '), {icon: 'telescope'})

atom.packages.serviceHub.provide 'pigments.expressions.colors', '1.0.0', {
  name: 'custom:rgb-lua-table'
  regexpString: "\{[ \t]*r[ \t]*=[ \t]*([0-9.]+)[ \t]*,[ \t]*g[ \t]*=[ \t]*([0-9.]+)[ \t]*,[ \t]*b[ \t]*=[ \t]*([0-9.]+)[ \t]*\}"
  scopes: ['*']
  handle: (match, expression, context) ->
    [t,r,g,b] = match

    r = context.readFloat(r) * 255
    g = context.readFloat(g) * 255
    b = context.readFloat(b) * 255
    @rgb = [r,g,b]

    @colorExpression = t
}

atom.packages.serviceHub.provide 'pigments.expressions.colors', '1.0.0', {
  name: 'custom:rgba-lua-table'
  regexpString: "\{[ \t]*r[ \t]*=[ \t]*([0-9.]+)[ \t]*,[ \t]*g[ \t]*=[ \t]*([0-9.]+)[ \t]*,[ \t]*b[ \t]*=[ \t]*([0-9.]+)[ \t]*,[ \t]*a[ \t]*=[ \t]*([0-9.]+)[ \t]*\}"
  scopes: ['*']
  handle: (match, expression, context) ->
    [t,r,g,b,a] = match

    r = context.readFloat(r) * 255
    g = context.readFloat(g) * 255
    b = context.readFloat(b) * 255
    a = context.readFloat(a) * 255
    @rgba = [r,g,b,a]

    @colorExpression = t
}
