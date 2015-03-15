$(document).ready () ->
  hammer = $('body').data('hammer')
  hammer.set
    preventDefault: true
  hammertime.get('pan').set
    threshold: 0
