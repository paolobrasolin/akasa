Template.cell.helpers
  selectedClass: () ->
    s = Diagrams.findOne
      _id: @diagramId
      selection: @_id
    if s then "selected" else null
###
  cellId: () ->
    @_id
###
Template.cell.gestures
  'tap path': () ->
    console.log @
    Meteor.call("toggleCell", @)
  'pan path': (event) ->
    origin = event.target.ownerSVGElement
    point = event.center
    relx = point.x - origin.offsetLeft
    rely = point.y - origin.offsetTop
    Meteor.call("moveCell", @_id, relx, rely)
###
  'press path': () ->
    Meteor.call("deleteCell", @_id)
###