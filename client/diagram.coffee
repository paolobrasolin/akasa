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



Template.diagram.helpers
  styleString: () ->
    "width:"+@size.x*100+"%;"+
      "height:"+@size.y*100+"%;"+
      "left:"+@position.x*100+"%;"+
      "top:"+@position.y*100+"%;"
  cellInDiagram: () ->
    Cells.find
      diagramId: @_id

Template.diagram.gestures

  'tap .diagram': (event,template) ->
    Session.set "ACTIVE_DIAGRAM", @diagramId or @_id
    Meteor.call("emptySelection", @_id)


  'doubletap svg': (event, template) ->
    console.log event
    targetClassList = event.target.classList.toString()
    if targetClassList is "diagram"
      point = event.center
      origin = event.target
      nux = point.x - origin.offsetLeft
      nuy = point.y - origin.offsetTop
      Meteor.call("createCell", @_id, 0, null, null, nux, nuy)
