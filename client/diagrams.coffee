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


Template.diagrams.helpers
  diagramInQuery: () -> @
  selectedCells: () ->
    currentSelectionIds()

  connectButtonDisabledClass: () ->
    "disabled" unless twoParallelCellsAreSelected()
  composeButtonDisabledClass: () ->
    "disabled"
  eraseButtonDisabledClass: () ->
    "disabled" unless selectionIsntEmpty()


Template.diagrams.gestures

  'tap #connectButton': () ->
    id = currentDiagramId()
    sel = currentSelection()
    k = 1+sel[0].order
    s = sel[0]._id
    t = sel[1]._id
    x = (sel[0].posx+sel[1].posx)/2
    y = (sel[0].posy+sel[1].posy)/2
    Meteor.call("createCell", id, k, s, t, x, y)

  'tap #eraseButton': () ->
    id = currentDiagramId()
    sel = currentSelectionIds()
    Meteor.call("deleteCells", sel)
    Meteor.call("emptySelection", id)
