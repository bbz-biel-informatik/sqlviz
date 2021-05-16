// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("jquery")
require("jquery-ui")
require("@nathanvda/cocoon")

document.addEventListener('turbolinks:load', function(){
  $('.sortable').sortable({
    placeholder: "ui-state-highlight",
    stop: function(event, ui) {
      const visuals = document.querySelectorAll('.sortable > div');
      const ids = [];
      visuals.forEach(v => ids.push(v.getAttribute('data-id')));

      var fd = new FormData();
      fd.append("sort", JSON.stringify(ids));

      $.ajax({
        url: document.querySelector('.sortable').getAttribute('data-url'),
        type : "POST",
        processData: false,
        contentType: false,
        data: fd
      });
    }
  });
});
