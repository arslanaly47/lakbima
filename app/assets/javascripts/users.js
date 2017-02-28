$(document).ready(function() {

  var hostname = window.location.origin;

  $("#autoGenerateUserPassword").change(function() {
    if($(this).is(":checked")) {
      $("#userCreationPasswordField").val("");
      $("#userCreationPasswordField").prop('disabled', true);
    } else {
      $("#userCreationPasswordField").prop('disabled', false);
    }
  });

  function showCurrentUsers() {
    $('.current-users').removeClass('hidden');
    $('.current-users').show();
    $('.past-users').hide();
    $('.future-users').hide();
    $("#totalUsers").text($('.current-users').length);
  }

  function showPastUsers() {
    $('.past-users').removeClass('hidden');
    $('.past-users').show();
    $('.current-users').hide();
    $('.future-users').hide();
    $("#totalUsers").text($('.past-users').length);
  }

  function showFutureUsers() {
    $('.future-users').removeClass('hidden');
    $('.future-users').show();
    $('.past-users').hide();
    $('.current-users').hide();
    $("#totalUsers").text($('.future-users').length);
  }

  var allUsers = $('.users:visible');

  $(".user-display").change(function() {
    if($(this).val() == "Current") {
      showCurrentUsers();
      allUsers = $('.employees:visible');
      return;
    }
    if($(this).val() == "Past") {
      showPastUsers();
      allUsers = $('.users:visible');
      return;
    }
    if($(this).val() == "Future") {
      showFutureUsers();
      allUsers = $('.users:visible');
      return;
    }
  });

  var terminateAUser = function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var userID = $this.data('user-id');

    var url = hostname + "/users/" + userID.toString() + "/terminate";

    $.ajax({
      type: "POST",
      url: url,
      success: function(data) {
        $this.ladda('stop');
        if (data.success) {
          $this.text('Unterminate');
          $this.data('confirm', "Are you sure you want to unterminate this user?");
          $this.removeClass('btn-danger');
          $this.removeClass('terminate-user');
          $this.addClass('btn-primary');
          $this.addClass('unterminate-user');
          $this.unbind('click');
          $this.bind('click', unterminateAUser);
        }
      }
    });
  };

  var unterminateAUser = function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var userID = $this.data('user-id');

    var url = hostname + "/users/" + userID.toString() + "/unterminate";

    $.ajax({
      type: "POST",
      url: url,
      success: function(data) {
        $this.ladda('stop');
        if (data.success) {
          $this.text('Terminate');
          $this.data('confirm', "Are you sure you want to terminate this user?");
          $this.removeClass('btn-primary');
          $this.removeClass('unterminate-user');
          $this.addClass('btn-danger');
          $this.addClass('terminate-user');
          $this.unbind('click');
          $this.bind('click', terminateAUser);
        }
      }
    });
  };

  var terminateButton, unterminateButton;

  if ($(".terminate-user").length) {
    terminateButton = $(".terminate-user").ladda();
    terminateButton.click(terminateAUser);
  } else {
    unterminateButton = $(".unterminate-user").ladda();
    unterminateButton.click(unterminateAUser);
  }

});
