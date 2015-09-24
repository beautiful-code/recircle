$(function() {
  var getNotifications = function(){
    $('#notify').click()
  };

  getNotifications();
  setInterval(getNotifications,30000);
});

