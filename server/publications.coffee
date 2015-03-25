Meteor.publish "cells", () ->
  Cells.find()

Meteor.publish "diagrams", () ->
  Diagrams.find()

Meteor.publish "blackboards", () ->
  Blackboards.find()

Meteor.publish "users", () ->
  Users.find()

Meteor.publish "groups", () ->
  Groups.find()