$(document).ready(function() {

  var hostname = window.location.origin;

  function updateNotificationCount() {
    var currentNotificationCount = parseInt($("#notificationCount").text());
    updatedCount = currentNotificationCount - 1;

    if(updatedCount == 0) {
      $("#notificationCount").remove();
    } else {
      $("#notificationCount").text(updatedCount);
    }
  }

  function removeNotification(notificationId) {
    $("#notification" + notificationId).remove();
    $("#divider" + notificationId).remove();
  }

  var leaveApprove = $(".leave-approve").ladda();
  var leaveDeny    = $(".leave-deny").ladda();
  var markAsRead   = $(".mark-as-read").ladda();

  leaveApprove.click(function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var leaveApplicationId = $(this).data('leave-application-id');
    var notificationId     = $(this).data('notification-id');

    var url = hostname + "/leave_applications/" + leaveApplicationId.toString() + "/approve";

    $.ajax({
      type: "POST",
      url: url,
      success: function(data) {
        $this.ladda('stop');
        $this.siblings('.leave-deny').remove();
        $this.before("<span class='label label-primary animated fadeInDown'>Approved</span>");
        $this.remove();
        if (data.read) {
          updateNotificationCount();
          removeNotification(notificationId);
        }
      }
    });
  });

  leaveDeny.click(function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var leaveApplicationId = $(this).data('leave-application-id');
    var notificationId     = $(this).data('notification-id');

    var url = hostname + "/leave_applications/" + leaveApplicationId.toString() + "/deny";

    $.ajax({
      type: "POST",
      url: url,
      success: function(data) {
        $this.ladda('stop');
        $this.siblings('.leave-approve').remove();
        $this.before("<span class='label label-danger animated fadeInDown'>Denied</span>");
        $this.remove();
        if (data.read) {
          updateNotificationCount();
          removeNotification(notificationId);
        }
      }
    });
  });

  markAsRead.click(function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var notificationId = $(this).data('notification-id');

    var url = hostname + "/notifications/" + notificationId.toString() + "/mark_as_read";

    $.ajax({
      type: "POST",
      url: url,
      success: function(data) {
        $this.ladda('stop');
        $this.before("<span class='label animated fadeInDown'>Read</span>");
        $this.remove();
        if (data.read) {
          updateNotificationCount();
          removeNotification(notificationId);
        }
      }
    });
  });
});
