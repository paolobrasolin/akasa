Template.diagram.helpers
  cellInDiagram: () ->
    Cells.find
      diagramId: @_id
  probe: () ->
  	console.log @

Template.diagram.gestures

  'tap svg': (event,template) ->
    #targetClassList = event.target.classList.toString()
    #point = event.center
    #nux = point.x - $("svg").offset().left
    #nuy = point.y - $("svg").offset().top
    console.log "TAP!"
    console.log @
    console.log event
    console.log template

  'doubletap svg': (event, template) ->
    targetClassList = event.target.classList.toString()
    if targetClassList is "diagram"
      point = event.center
      origin = $("#"+@_id).offset()
      nux = point.x - origin.left
      nuy = point.y - origin.top
      Meteor.call("createCell", @_id, nux, nuy, null, null)
