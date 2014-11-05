// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


$(document).ready(function () {

  // Set a variable that is set to the div containing the overlay (created on page load)
  var page_overlay = jQuery('<div id="overlay"> </div>');

  // Function to Add the overlay to the page
  function showOverlay(){
    page_overlay.appendTo($("#search_result"));
  }
  // Function to Remove the overlay from the page
  function hideOverlay(){
    page_overlay.remove();
  }

  $('button.btn-success').click(function() {
    $('div.alert').remove();
    $(showOverlay);
  });
});
