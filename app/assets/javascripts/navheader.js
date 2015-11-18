$(document).ready(function(){
  var p= $('.share-book').position();
  var $isbn_form=$('.isbn-form')
  $isbn_form.css({left:p.left-100});
  $('.share-book').click(function(){
    $isbn_form.toggle();
  });
});
