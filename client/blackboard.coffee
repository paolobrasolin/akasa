Template.blackboard.helpers
  getDiagram: () ->
    Diagrams.findOne
      _id: @diagramId

  isBlank: () ->
    @kind is 'blank'
  isDiagram: () ->
    @kind is 'diagram'
  isSplit: () ->
    @kind is 'split'

  isWhole: () ->
    @kind is 'whole'

  slates: () ->
    @slates.map (id) ->
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
  
  style: () ->
    if @splitting is 'vertical'
      "flex-direction:column;"
    else if @splitting is 'horizontal'
      "flex-direction:row;"


Template.blackboard.gestures
  'tap .blackboard': (event,template) ->
    console.log "TAP!"
    #console.log @
    #console.log event
    #console.log template
    #event.stopPropagation
    #Session.set "ACTIVE_DIAGRAM", @diagramId or @_id
    #Meteor.call("emptySelection", @_id)
