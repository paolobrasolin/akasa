Meteor.methods
  createCell: (id, x, y, s, t) ->
    #if (!Meteor.userId())
    #  throw new Meteor.Error("not-authorized")
    Cells.insert
      diagramId: id
      posx: x
      posy: y
      source: s
      target: t
  toggleCell: (c) ->
    s = Diagrams.findOne
      _id: c.diagramId
      selection: c._id
    if s
      Diagrams.update c.diagramId,
        $pull:
          selection: c._id
    else
      Diagrams.update c.diagramId,
        $push:
          selection: c._id
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
