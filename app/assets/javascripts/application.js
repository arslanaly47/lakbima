// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery/jquery-2.1.1.js
//= require jquery_ujs
//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require slimscroll/jquery.slimscroll.min.js
//= require jquery_nested_form
//= require blueimp-gallery-all
//= require toastr/toastr.min.js
//= require_self
//= require_tree .

// Defining toastr options site wide
$(document).ready(function () { 
  toastr.options = {
    "closeButton": true,
    "progressBar": true,
    "showDuration": "400",
    "hideDuration": "1000",
    "timeOut": "7000",
    "showEasing": "swing",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  };

  Pace.options.ajax.trackWebSockets = false;
});
