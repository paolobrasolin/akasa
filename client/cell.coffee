class Point
  constructor: (x, y) ->
    @x = x or 0
    @y = y or 0
  add: (q) -> @x += q.x; @y += q.y; @
  sub: (q) -> @x -= q.x; @y -= q.y; @
  mul: (k) -> @x *= k;   @y *= k;   @
  div: (k) -> @x /= k;   @y /= k;   @

linterp = (i, f, t) ->
  p = new Point
  p.add(f).sub(i).mul(t).add(i)

class QuadraticBezier
  constructor: (i, f, c) ->
    @i = i
    @f = f
    @c = c #or i.add(f).div(2)
  _il: (t) -> linterp(@i, @c, t)
  _fl: (t) -> linterp(@c, @f, t)
  parametric: (t) ->
    linterp(@_il(t), @_fl(t), t)
  setMidpoint: (p) ->
    @c = p.mul(4).sub(@i).sub(@f).div(2)
    @
  cutAfter: (t) ->
    @f = @parametric(t)
    @c = @_il(t)
    @

  cutBefore: (t) ->
    @i = @parametric(t)
    @c = @_fl(t)
    @

  svgString: () ->
    "M"+@i.x+" "+@i.y+"Q"+
        @c.x+" "+@c.y+" "+
        @f.x+" "+@f.y



###
norm = (v) ->
  Math.sqrt(Math.pow(v.x,2)+Math.pow(v.y,2))

diff = (p, q) ->
  x: p.x-q.x
  y: p.y-q.y

vec = (i, f) ->
  diff(f, i)

dist = (i, f) ->
  norm(vec(i, f))


cross = (v, w) ->
  v.x*w.y-v.y*w.x

dot = (v, w) ->
  v.x*w.x+v.y*w.y
###

Template.cell.helpers
  selectedClass: () ->
    s = Diagrams.findOne
      _id: @diagramId
      selection: @_id
    if s then "selected" else null


  cellPath: () ->

    if @order is 0
      "M"+@x+" "+@y+"L"+@x+" "+@y

    else if @order is 1
      s = Cells.findOne
        _id: @source
      t = Cells.findOne
        _id: @target

      sp = new Point s.x, s.y
      cp = new Point @.x, @.y
      tp = new Point t.x, t.y

      new QuadraticBezier sp, tp
        .setMidpoint(cp)
        .cutBefore(0.2)
        .cutAfter(0.8)
        .svgString()

    else if @order is 2
      s = Cells.findOne
        _id: @source
      t = Cells.findOne
        _id: @target

      sp = new Point s.x, s.y
      cp = new Point @.x, @.y
      tp = new Point t.x, t.y

      new QuadraticBezier sp, tp
        .setMidpoint(cp)
        .cutBefore(0.2)
        .cutAfter(0.8)
        .svgString()






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

