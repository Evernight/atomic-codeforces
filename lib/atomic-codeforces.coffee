AtomicCodeforcesView = require './atomic-codeforces-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomicCodeforces =
  atomicCodeforcesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomicCodeforcesView = new AtomicCodeforcesView(state.atomicCodeforcesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomicCodeforcesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atomic-codeforces:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomicCodeforcesView.destroy()

  serialize: ->
    atomicCodeforcesViewState: @atomicCodeforcesView.serialize()

  toggle: ->
    console.log 'AtomicCodeforces was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
