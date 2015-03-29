Template.topbar.helpers
  editModeIcon:() ->
    currentMode = Session.get "EDIT_MODE"
    if currentMode is "diagram"
      "mdi-action-view-quilt"
    else 
      "mdi-editor-mode-edit"
        

Template.topbar.gestures

  'tap #editModeToggler': () ->
    currentMode = Session.get "EDIT_MODE"
    if currentMode is "diagram"
      Session.set "EDIT_MODE", "blackboard"
    else 
      Session.set "EDIT_MODE", "diagram"
