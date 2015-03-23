// dev'essere js per avere variabili globali

//Users = new Meteor.Collection('users'); // GIÀ è definito
Diagrams = new Meteor.Collection('diagrams');
Cells = new Meteor.Collection('cells');
Blackboards = new Meteor.Collection('blackboards');

/*
###
 Calculate a default name for a list in the form of 'List A'
Diagrams.defaultName = function() {
  var nextLetter = 'A', nextName = 'List ' + nextLetter;
  while (Diagrams.findOne({name: nextName})) {
    // not going to be too smart here, can go past Z
    nextLetter = String.fromCharCode(nextLetter.charCodeAt(0) + 1);
    nextName = 'List ' + nextLetter;
  }
  return "New diagram"; // nextName
};
###
*/