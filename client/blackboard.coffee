Template.blackboard.helpers

  isBlank: () ->
    !@kind?
  isDiagram: () ->
    @kind is 'diagram'
  isBlackboards: () ->
    @kind is 'blackboards'

  getDiagram: () ->
    Diagrams.findOne
      _id: @diagramId

  getBlackboards: () ->
    @blackboards.map (id) ->
      Blackboards.findOne
        _id: id
    ###
    for _, i in s
      w = (@handles[i] or 1) - (@handles[i-1] or 0)
      if @splitting is 'vertical'
        dim = 'height'
        dir = 'top'
      else if @splitting is 'horizontal'
        dim = 'width'
        dir = 'left'
      s[i]._style = dim+':'+(w*100)+'%'
    s
    ###
  
  direction: () ->
    if @direction is 'vertical'
      "flex-direction:column;"
    else if @direction is 'horizontal'
      "flex-direction:row;"


Template.blackboard.gestures
  'tap main > .blackboard': (event,template) ->
    console.log "Tapped template"+@_id
    console.log template
    #console.log template
    #event.stopPropagation
    #Session.set "ACTIVE_DIAGRAM", @diagramId or @_id
    #Meteor.call("emptySelection", @_id)

