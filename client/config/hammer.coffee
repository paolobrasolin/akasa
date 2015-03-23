$(document).ready () ->
  hammer = $('body').data('hammer')
  hammer.set
    domEvents: true
    preventDefault: true
  hammer.get('pan').set
    pointers: 1
    threshold: 0
