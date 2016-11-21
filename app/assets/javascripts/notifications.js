$(document).ready(function() {

  function updateNotificationCount() {
    var currentNotificationCount = parseInt($("#notificationCount").text());
    updatedCount = currentNotificationCount - 1;

    if(updatedCount == 0) {
      $("#notificationCount").remove();
    } else {
      $("#notificationCount").text(updatedCount);
    }
  }

  var leaveApprove = $(".leave-approve").ladda();
  var leaveDeny    = $(".leave-deny").ladda();

  leaveApprove.click(function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var leaveApplicationId = $(this).data('leave-application-id');

    var url = "leave_applications/" + leaveApplicationId.toString() + "/approve";

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
        }
      }
    });
  });

  leaveDeny.click(function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var leaveApplicationId = $(this).data('leave-application-id');

    var url = "leave_applications/" + leaveApplicationId.toString() + "/deny";

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
        }
      }
    });
  });
});
