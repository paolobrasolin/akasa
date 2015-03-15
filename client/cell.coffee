Template.cell.helpers
  selectedClass: () ->
    s = Diagrams.findOne
      _id: @diagramId
      selection: @_id
    if s then "selected" else null
  #probe: () ->
  #  console.log ($(this).parent())
  #  console.log @
###
  cellId: () ->
    @_id
###
Template.cell.gestures
  'tap path': () ->
    console.log @
    Meteor.call("toggleCell", @)
  'panstart .tactile, pan .tactile, panstop .tactile': (event) ->
    origin = $("#"+@diagramId).offset()
    point = event.center
    relx = point.x - origin.left
    rely = point.y - origin.top
    Meteor.call("moveCell", @_id, relx, rely)
###
  'press path': () ->
    Meteor.call("deleteCell", @_id)
###