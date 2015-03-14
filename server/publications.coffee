# pubblichiamo solo diagrammi su cui utente corrente ha diritti

Meteor.publish "editableDiagrams", () ->
  Diagrams.find
    editors: @userId

Meteor.publish "publicDiagrams", () ->
  Diagrams.find
    editors: null

Meteor.publish "viewableDiagrams", () ->
  Diagrams.find
    viewers: @userId

Meteor.publish "showcaseDiagrams", () ->
  Diagrams.find
    viewers: null

# moralmente sarebbe più corretto pubblicare solo celle che gli appartengono
# ma tanto limito operazioni con permessi su metodi a livello server
Meteor.publish "allCells", () ->
  Cells.find()
