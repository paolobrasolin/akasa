Template.diagram.helpers

  cells: () ->
    Cells.find
      diagramId: @_id

  diagramId: () ->
    #console.log(@)
    #console.log(@._id)
    #console.log(@_id)
    @_id

  canCreateNewCell: () ->
    sel = @selection
    if sel.length isnt 2
      false
    else
      s = Cells.findOne
        _id: sel[0]
      t = Cells.findOne
        _id: sel[1]
      s.source is t.source and s.target is t.target



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

  'tap svg': (event,template) ->
    targetClassList = event.target.classList.toString()

  'doubletap svg': (event, template) ->
    targetClassList = event.target.classList.toString()
    if targetClassList is "diagram"
      point = event.center
      nux = point.x - $("svg").offset().left
      nuy = point.y - $("svg").offset().top
      Meteor.call("createCell", @_id, nux, nuy, null, null)
