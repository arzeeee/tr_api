// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "semantic-ui"

import jquery from "jquery"
window.$ = jquery
window.jQuery = jquery

$('.close')
  .on('click', function() {
    $(this)
      .closest('.message')
      .hide()
    ;
  })
;