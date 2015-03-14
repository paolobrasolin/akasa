Template.editor.helpers

  editableDiagrams: () ->
    query = {}
    query.editors = {$all: [Meteor.userId()]}
    Diagrams.find query

  accessible: () ->
    query = {}
    Diagrams.find query

  viewableDiagrams: () ->
    query = {}
    query.viewers = {$all: [Meteor.userId()]}
    Diagrams.find query

  filteredDiagrams: (rw, r) ->
    query = {}
    if rw? and rw isnt []
      query.editors = {$all: rw}
    if r? and r isnt []
      query.viewers = {$all: r}
    Diagrams.find query

Template.editor.gestures

  'tap .new-diagram-button': () ->
    Meteor.call("createDiagram")
    #Router.go 'diagram', i