Template.user.helpers

  # naturalmente la ricerca viene effettuara solo su diagrammi
  # su cui l'utente attuale abbia dei diritti
  diagramsFilter: (writeGrp, readGrp) ->
    #key
    Diagrams.find
      editors: {$all: writeGrp}
      viewers: {$all: readGrp}




  isCurrent: () ->
    @_id is Meteor.userId()

  exists: () ->
    @_id is null or @_id?

  owned: () ->
    Diagrams.find
      editors: Meteor.userId()

  visible: () ->
    Diagrams.find
      viewers: Meteor.userId()

  coowned: () ->
    Diagrams.find
      editors: {$all: [@_id, Meteor.userId()]}

  shared: () ->
    Diagrams.find
      editors: @_id
      viewers: Meteor.userId()

