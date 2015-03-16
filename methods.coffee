distance = (p, q) ->
  Math.sqrt(Math.pow(q.x-p.x,2)+Math.pow(q.y-p.y,2))

angle = (o, p) ->
  Math.atan2(p.y-o.y,p.x-o.x)

# origin. initial, final, point to trasform
similarity = (o, i, f, p) ->
  initialDistance = distance o, i
  finalDistance = distance o, f
  scaling = finalDistance/initialDistance
  initialAngle = angle o, i
  finalAngle = angle o, f
  rotation = finalAngle-initialAngle
  p.x -= o.x
  p.y -= o.y
  p.x *= scaling
  p.y *= scaling
  q = {}
  q.x = p.x*Math.cos(rotation)-p.y*Math.sin(rotation)
  q.y = p.x*Math.sin(rotation)+p.y*Math.cos(rotation)
  q.x += o.x
  q.y += o.y
  q


Meteor.methods
  createCell: (id, k, s, t, x, y) ->
    #if (!Meteor.userId())
    #  throw new Meteor.Error("not-authorized")
    Cells.insert
      diagramId: id
      posx: x
      posy: y
      order: k
      source: s
      target: t
  emptySelection: (id) ->
    Diagrams.update id,
      $set:
        selection: []
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
    j = Cells.findOne
      _id: id
    i = {}
    i.x = j.posx
    i.y = j.posy
    f = {}
    f.x = x
    f.y = y

    sourceables = Cells.find
      source: id
    sourceables.forEach (c) ->
      tar = Cells.findOne
        _id: c.target
      o = {}
      o.x = tar.posx
      o.y = tar.posy
      p = {}
      p.x = c.posx
      p.y = c.posy
      q = {}
      q = similarity(o, i, f, p)
      Cells.update c._id,
        $set:
          posx: q.x
          posy: q.y



    Cells.update id,
      $set:
        posx: x
        posy: y
  deleteCell: (id) ->
    Cells.remove id
  deleteCells: (idl) ->
    Cells.remove
      _id:
        $in: idl

  createDiagram: (name) ->
    Diagrams.insert
      name: name or "New diagram"
      editors: [Meteor.userId()]
      viewers: []
