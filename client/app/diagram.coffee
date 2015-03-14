Template.diagram.helpers

  cells: () ->
    Cells.find
      diagramId: @_id

  diagramId: () ->
    #console.log(@)
    #console.log(@._id)
    #console.log(@_id)
    @_id

###
  minX: (id) ->
    Cells.findOne({diagramId: id}, {sort: {posx: 1}}).posx
  maxX: (id) ->
    Cells.findOne({diagramId: id}, {sort: {posx: -1}}).posx
  minY: (id) ->
    Cells.findOne({diagramId: id}, {sort: {posy: 1}}).posy
  maxY: (id) ->
    Cells.findOne({diagramId: id}, {sort: {posy: -1}}).posy
###

Template.diagram.gestures

  'tap svg': (event) ->
    #console.log "Tap in diagram!"

  'doubletap svg': (event, template) ->
    point = event.center
    #console.log @
    #console.log event
    #console.log template
    nux = point.x - $("svg").offset().left
    nuy = point.y - $("svg").offset().top
    Meteor.call("createCell", @_id, nux, nuy)
