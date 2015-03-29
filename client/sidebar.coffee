Template.sidebar.helpers

  favouriteBlackboards: () ->
    Blackboards.find()


Template.sidebar.gestures

  'tap #newBlackboardButton': () ->
    Meteor.call "newBlackboard", (_,r) ->
      Router.go "blackboard", {_id: r}
