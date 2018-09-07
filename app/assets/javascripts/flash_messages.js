$(document).on('turbolinks:load', function () {
  hideAlert(3);

  function hideAlert(coefficient) {
    var $flashMessage = $('div.alert'),
        duration = coefficient * 100;

    $flashMessage.fadeOut(duration);
  };

  $('div.alert').fadeOut(100);
});
