// page:load event is for turbolinks
$(document).on("page:load ready", function() {
  var resource_link = $('#resource-link');
  
  if (resource_link.length > 0) {
    var updated_at = parseInt($('#resource-updated-at').text(), 10);

    var show_updated = function() {
      resource_link.after("<div class='alert alert-warning'>this " + resource_link.text() + " has been edited since you opened it.  refresh the page to see the new content!</div>");
    };

    var check_if_updated = function() {
      $.get(resource_link.attr("href"), function(data) {
        if (data.updated_at > updated_at) {
          updated_at = data.updated_at;
          show_updated(updated_at);
        } else {
          setTimeout(check_if_updated, 2000);
        }
      }, "json");
    };

    check_if_updated();
  }
});
