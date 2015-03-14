Template.cell.helpers

  selectedClass: () ->
    (@selected % 2) and 'selected'

  cellId: () ->
    @_id

Template.cell.gestures

  'tap path': () ->
    Meteor.call("selectCell", @_id)

  'pan path': (event) ->
    origin = event.target.ownerSVGElement
    point = event.center
    relx = point.x - origin.offsetLeft
    rely = point.y - origin.offsetTop
    Meteor.call("moveCell", @_id, relx, rely)

  'press path': () ->
    Meteor.call("deleteCell", @_id)
