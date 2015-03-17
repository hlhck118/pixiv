function init() {
  $(".button-collapse").sideNav();

  if (flash_message !== '') {
    toast(flash_message, 3000, 'grey lighten-5')
  }

  $('input[type="text"]').each(function(index, el) {
    if ($(this).val() != '') {
      $("label[for='" + this.id + "']").addClass('active');
    }
  });

  $('textarea').each(function(index, el) {
    if ($(this).val() != '') {
      $(this).prev('label').addClass('active');
      $("label[for='" + this.id + "']").addClass('active');
    }
  });
}

function baseName(str) {
  str = str.split(/[\\/]/).pop();
  return str;
}
