linterp = (a, b, t) ->
  a+(b-a)*t





# linearly invert to obtain control point from midtangent
tcp = (i, p, f) ->
  (4*p-i-f)/2

ofs = (ix, iy, l, fx, fy) ->
  d = Math.sqrt(Math.pow(fx-ix,2)+Math.pow(fy-iy,2))
  p =
    x: ix+l*(fx-ix)/d
    y: iy+l*(fy-iy)/d


Template.cell.helpers
  selectedClass: () ->
    s = Diagrams.findOne
      _id: @diagramId
      selection: @_id
    if s then "selected" else null


  cellPath: () ->
    if @order is 0
      "M"+@posx+" "+@posy+"L"+@posx+" "+@posy
    else if @order is 1
      s = Cells.findOne
        _id: @source
      t = Cells.findOne
        _id: @target
      tcpx = tcp(s.posx, @posx, t.posx)
      tcpy = tcp(s.posy, @posy, t.posy)
      ofss = ofs(s.posx, s.posy, 50, tcpx, tcpy)
      ofst = ofs(t.posx, t.posy, 50, tcpx, tcpy)
      qcpx = tcp(ofss.x, @posx, ofst.x)
      qcpy = tcp(ofss.y, @posy, ofst.y)
      "M"+ofss.x+" "+
          ofss.y+"Q"+
          qcpx+" "+
          qcpy+" "+
          ofst.x+" "+
          ofst.y
    else if @order is 2
      ""


  #probe: () ->
  #  console.log ($(this).parent())
  #  console.log @
###
  cellId: () ->
    @_id
###
Template.cell.gestures
  'tap .cell.tactile': () ->
    console.log @
    Meteor.call("toggleCell", @)
  'panstart .tactile, pan .tactile, panstop .tactile': (event) ->
    #console.log event
    origin = $("#"+@diagramId).offset()
    point = event.center
    relx = point.x - origin.left
    rely = point.y - origin.top
    Meteor.call("moveCell", @_id, relx, rely)
###
  'press path': () ->
    Meteor.call("deleteCell", @_id)
###

