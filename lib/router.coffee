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
    layoutTemplate: 'website'
    path: '/'
  ###
  @route 'diagram',
    layoutTemplate: 'editor'
    path: '/diagrams/:_id'
    data: () ->
      Diagrams.findOne(@params._id)
  ###

  @route 'diagrams',
    layoutTemplate: ''
    path: '/diagrams/:_ids'
    data: () ->
      #console.log (@params._ids.split(","))
      #_.map sanitizeIds(@params._ids, Diagrams), (x) -> Diagrams.find({_id:x})
      Diagrams.find
        _id:
          $in: @params._ids.split(",")
    onBeforeAction: () ->
      Session.set "viewports", []
      @data().forEach ()->Session.get("viewports").push("NU")
      console.log (@data().fetch())
      Session.set "view", (@params._ids.split(","))
      @next()

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
