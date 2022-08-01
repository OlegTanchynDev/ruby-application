import consumer from "./consumer"

function RealNotification(data) {
  this.notificationDiv       = $('[data-notification=real-notification]');
  this.notificationTitle     = this.notificationDiv.find('#title');
  this.notificationMessage   = this.notificationDiv.find('#message');
  this.setOptions(data);
}

RealNotification.prototype.setOptions = function(data) {
  this.notificationHideDelay = (data && data.delay) ? data.delay : 6000;
  this.notificationPosition  = (data && data.position) ? data.position : 'top-right';
};

RealNotification.prototype.CSS_CLASSES = {
  topRight    : 'notification-top-right',
};

RealNotification.prototype.show = function(response) {
  $('[data-notification=real-notification]').fadeIn();
  this.positionNotification()
  this.notificationTitle.text(response.title);
  this.notificationMessage.text(response.message);
  this.notificationDiv.show()
      .delay(this.notificationHideDelay)
      .fadeOut();
};

RealNotification.prototype.positionNotification = function() {
  switch(this.notificationPosition) {

    case 'top-right':
      this.notificationDiv.addClass(this.CSS_CLASSES.topRight);
      break;

    default:
      alert('RealNotification: Invalid position option supplied.');
  }
};


consumer.subscriptions.create("NotificationChannel", {
  received: function(data) {
    var notification = new RealNotification({
      delay: 6000, // default hide notification delay is 6000
      position: 'top-right' // default position is top-right see available options below
    });
    notification.show(data);
  }
});
