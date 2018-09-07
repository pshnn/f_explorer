$(document).on('turbolinks:load', function () {
  const SUCCESS_CLASS = 'success'
  const WARNING_CLASS = 'warning'

  $(function () {
    $('[data-toggle="popover"]').popover();
  });

  $('.popover-dismiss').popover({
  trigger: 'focus'
})

  var $mainCheckbox = $('input#main[type=checkbox]'),
      $tableBodyCheckboxes = $('tbody input[type=checkbox]'),
      $batchDeleteButton = $('#batchDelete'),
      $deleteAction = $('a.dropdown-item');

  $mainCheckbox.change(function () {
    var value = $mainCheckbox[0].checked;

    changeCheckboxesStatus($tableBodyCheckboxes, value)
  });

  $batchDeleteButton.on('click', function () {
    var pathsToDelete = getPathOfCheckedRows();
    if (pathsToDelete.length == 0) {
      displayFlash(WARNING_CLASS,'Select some files or folders!');
    } else {
      deleteFiles(pathsToDelete);
    };
  });

  $deleteAction.on('click', function () {
    var path = $(this).closest('tr').data('path');
    deleteFile(path);
  });

  hideFlash(30);

  function changeCheckboxesStatus (collection, value) {
    collection.each(function () {
      $(this).prop('checked', value);
    });
  };

  function getPathOfCheckedRows () {
    var path_collection = [],
        $checkedCheckboxes = $('tbody input[type=checkbox]:checked');

    $checkedCheckboxes.each(function () {
      $row = $(this).closest('tr');
      path_collection.push($row.data('path'));
    });

    return path_collection;
  };

  function displayWarningFlash (message) {
    var flash = buildFlash(message);

    displayFlash(flash);
    hideFlash(25);


  };

  function displayFlash (type, message) {
    var $flashContainer = $('div.flash-messages'),
        buildedFlash = buildFlash(type, message);

    $flashContainer.append(buildedFlash);

    hideFlash(25);

    function buildFlash (type, message) {
      var element =
        `<div class="alert alert-${type}" role="alert">${message}</div>`;

      return element;
    };
  };

  function hideFlash (coefficient) {
    $('div.alert').fadeOut(coefficient * 100);
  };

  function deleteFiles (paths) {
    paths.forEach(function (value) { deleteFile(value); });
  };

  function deleteFile (path) {
    var url = '/delete_file';

    $.ajax({
      method: 'DELETE',
      headers: { 'X-CSRF-Token': getCSRFToken() },
      url: url,
      data: { path: path },
      success: function (response) {
        var flashMessage =
          `${response.payload.filename} was successfully deleted!`;

        hideRow(response.payload.path);
        displayFlash(SUCCESS_CLASS, flashMessage);
      }
    });

    function getCSRFToken () {
      return $('meta[name="csrf-token"]').attr('content');
    };

    function hideRow (path) { $('tr[data-path="' + path + '"]').hide(); };
  };
});
