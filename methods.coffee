Meteor.methods
  createCell: (id, x, y) ->
    #if (!Meteor.userId())
    #  throw new Meteor.Error("not-authorized")
    Cells.insert
      diagramId: id
      posx: x
      posy: y
  selectCell: (id) ->
    Cells.update id,
      $inc:
        selected: 1
  moveCell: (id, x, y) ->
    Cells.update id,
      $set:
        posx: x
        posy: y
  deleteCell: (id) ->
    Cells.remove id

  createDiagram: (name) ->
    Diagrams.insert
      name: name or "New diagram"
      editors: [Meteor.userId()]
      viewers: []

#  getUser: (id) ->
#    Meteor.