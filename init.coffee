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
