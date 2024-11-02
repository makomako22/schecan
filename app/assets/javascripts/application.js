 // This is a manifest file that'll be compiled into application.js, which will include all the files
 // listed below.
 //
 // Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
 // or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
 //
 // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
 // compiled file.
 //
 // Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
 // about supported directives.
 //
 //= require jquery
 //= require jquery_ujs
 //= require_tree .
 $(".button-collapse").sideNav();
 $( document ).ready(function(){
   $(".button-collapse").sideNav();
 });

 // Add code to display an alert using sweetalert.min.js when the check_alert method triggers it
 function showAlert(message) {
   swal({
     title: "Alert",
     text: message,
     icon: "warning",
     button: "OK",
   });
 }

 // Check if there is an alert message from the server
 $(document).ready(function() {
   var alertMessage = "<%= flash[:alert] %>";
   if (alertMessage) {
     showAlert(alertMessage);
   }
 });
