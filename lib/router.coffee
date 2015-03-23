sum = (array) ->
  array.reduce (a,b) -> a+b

parseLayout = (layout) ->
  deepest = /(\(\d+(\W)+(\d+\2+)+(?!(\d*\2*)*\())|(?![0-9]+)\w+/g
  i = 0
  atoms = []
  while newAtoms = layout.match deepest
    atoms = atoms.concat newAtoms
    layout = layout.replace deepest, () -> i++
  atoms = atoms.map (a) ->
    content: a
    position: {x: 0, y: 0}
    size: {x: 1, y: 1}
  while atoms[-1..][0]?.content.match /^\(/
    a = atoms.pop()
    axis = a.content.match /\W$/
    axis = if axis[0] is ',' then "x" else "y"
    indices = a.content.match /\w+/g
    weights = a.content.match /(?!^)(\W)\1*/g
    indices = indices.map (i) -> parseInt i
    weights = weights.map (w) -> w.length
    total = sum weights
    weights.unshift(0)
    for i, n in indices
      atoms[i].position[axis] += (sum weights[0..n])/total
      atoms[i].size[axis] *= weights[n+1]/total
      atoms[i].size.x *= a.size.x
      atoms[i].size.y *= a.size.y
      atoms[i].position.x *= a.size.x
      atoms[i].position.y *= a.size.y
      atoms[i].position.x += a.position.x
      atoms[i].position.y += a.position.y
  atoms








#Router.configure
  # we use the  appBody template to define the layout for the entire app
  #layoutTemplate: 'appBody'
  # the appNotFound template is used for unknown routes and missing diagrams
  #notFoundTemplate: 'appNotFound'
  # show the appLoading template whilst the subscriptions below load their data
  #loadingTemplate: 'appLoading'
  # wait on the following subscriptions before rendering the page to ensure
  # the data it's expecting is present
  #waitOn: () -> [
  #  Meteor.subscribe 'diagrams'
    #Meteor.subscribe 'privateDiagrams'
  #]

#dataReadyHold = null

#if Meteor.isClient
  # Keep showing the launch screen on mobile devices until we have loaded
  # the app's data
  #dataReadyHold = LaunchScreen.hold()
  # Show the loading screen on desktop
  #Router.onBeforeAction 'loading',
  #  except: ['join', 'signin']
  #Router.onBeforeAction 'dataNotFound',
  #  except: ['join', 'signin']

sanitizeIds = (query, collection) ->
  _.filter query.split(","), (x) -> collection.findOne({_id:x})

Router.map () ->

  @route 'home',
    layoutTemplate: ''
    path: '/'
  ###
  @route 'diagram',
    layoutTemplate: 'editor'
    path: '/diagrams/:_id'
    data: () ->
      Diagrams.findOne(@params._id)
  ###

  @route 'blackboard',
    layoutTemplate: ''
    path: '/blackboards/:_id'
    data: () ->
      Blackboards.findOne(@params._id)

  @route 'dashboard',
    layoutTemplate: ''
    path: '/-/'
    data: () ->
      null


  @route 'diagrams',
    template: 'diagram'
    layoutTemplate: 'editor'
    path: '/diagrams/:_id'
    data: () ->
      Diagrams.findOne
        _id: @params._id





  @route 'user',
    layoutTemplate: ''
    path: '/users/:_id' 
    data: () ->
      Meteor.users.findOne(@params._id)

  @route 'nouser',
    template: 'user'
    layoutTemplate: ''
    path: '/users/' 
    data: () ->
      {_id:null}

    # subscribe to cells before the page is rendered but don't wait on the
    # subscription, we'll just render the items as they arrive
    #onBeforeAction: () ->
      #@diagramCells = Meteor.subscribe('cells', @params._diagramId)
      #if @ready()
        # Handle for launch screen defined in app-body.js
        #dataReadyHold.release()
    #action: () ->
    #  @render()




###
layout = parseLayout @params._ids
for viewport, i in layout
  layout[i].content = Diagrams.findOne _id: viewport.content
layout
onBeforeAction: () ->
  Session.set "layout", parseLayout @params._ids
  @next()
###