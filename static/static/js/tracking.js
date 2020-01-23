window.onload = function() {
  var createEvent = function(id, eventName) {
    document.getElementById(id).onclick = function(event) {
      analytics.track(eventName);
      event.preventDefault();
      var href = document.getElementById(id).getAttribute("href");
      if (href) setTimeout(function () { window.location = href; }, 100);
    }
  }

  // Social icons
  createEvent("sidebar-email", "Clicked Email Icon");
  createEvent("sidebar-twitter", "Clicked Twitter Icon");
  createEvent("sidebar-github", "Clicked Github Icon");
  createEvent("sidebar-skype", "Clicked Skype Icon");
  createEvent("sidebar-rss", "Clicked RSS Icon");
  createEvent("sidebar-linkedin", "Clicked LinkedIn Icon");

  // Navigation
  createEvent("avatar", "Clicked Face");

  // Twitter Post Link
  createEvent("follow", "Clicked Twitter Follow Link");
}
