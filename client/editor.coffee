currentDiagramId = () ->
  Session.get "ACTIVE_DIAGRAM"

currentDiagram = () ->
  Diagrams.findOne
    _id: currentDiagramId()

currentSelectionIds = () ->
  currentDiagram().selection

currentSelection = () ->
  s = Cells.find
    _id:
      $in: currentSelectionIds()
  s.fetch()

twoParallelCellsAreSelected = () ->
  s = currentSelection()
  s.length is 2 and s[0].source is s[1].source and s[0].target is s[1].target

selectionIsntEmpty = () ->
  currentSelection().length isnt 0


Template.editor.helpers
  diagramInLayout: () -> @
  
  selectedCells: () ->
    currentSelectionIds()

  connectButtonDisabledClass: () ->
    "disabled" unless twoParallelCellsAreSelected()
  composeButtonDisabledClass: () ->
    "disabled"
  eraseButtonDisabledClass: () ->
    "disabled" unless selectionIsntEmpty()
  connectionStatus: () ->
    Meteor.status().status


Template.editor.gestures

  'tap #createButton': () ->
    id = currentDiagramId()
    sel = currentSelection()
    k = 1+sel[0].order
    s = sel[0]._id
    t = sel[1]._id
    x = (sel[0].x+sel[1].x)/2
    y = (sel[0].y+sel[1].y)/2
    Meteor.call("createCell", id, k, s, t, x, y)

  'tap #deleteButton': () ->
    id = currentDiagramId()
    sel = currentSelectionIds()
    Meteor.call("deleteCells", sel)
    Meteor.call("emptySelection", id)
