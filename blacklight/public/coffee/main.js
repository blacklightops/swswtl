(function() {
  var $;

  $ = jQuery;

  $(document).ready(function() {
    return $('#chatform').submit(function(e) {
      $.ajax({
        type: 'post',
        url: '/message',
        data: $('#chatform').serialize()
      });
      return e.preventDefault();
    });
  });

}).call(this);


//# sourceMappingURL=/coffee/main.map
//@ sourceMappingURL=/coffee/main.map