$( document ).on('turbolinks:load', function() {
 var navListItems = $('div.setup-panel div a'),
 allWells = $('.setup-content'),
 allNextBtn = $('.nextBtn');
 allBackBtn = $('.backBtn');

 allWells.hide();

 navListItems.each( function (){

  if( $(this).hasClass('disabled')){
    $(this).off('click');
  }
});
 navListItems.click(function (e) {
  e.preventDefault();
  var $target = $($(this).attr('href')),
  $item = $(this);

  if (!$item.hasClass('disabled')) {
    navListItems.removeClass('btn-primary').addClass('btn-default');
    $item.addClass('btn-primary');
    allWells.hide();
    $target.show();
    $target.find('input:eq(0)').focus();
  }
});

 var fileUploadErrors = {
  maxFileSize: 'File is too big',
  minFileSize: 'File is too small',
  acceptFileTypes: 'Filetype not allowed',
  maxNumberOfFiles: 'Max number of files exceeded',
  uploadedBytes: 'Uploaded bytes exceed file size',
  emptyResult: 'Empty file upload result'
}



allNextBtn.click(function(){
 /* var curStep = $(this).closest(".setup-content"),
 curStepBtn = curStep.attr("id"),
 nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
 curInputs = curStep.find("input[type='text'],input[type='url']");
 var valid = true;
 // this will cycle through all visible inputs and attempt to validate all of them.
 // if validations fail 'valid' is set to false
 $('[data-validate] input:visible').each(function() {
  var settings = window.ClientSideValidations.forms[this.form.id]
  if (!$(this).isValid(settings.validators)) {
    valid = false
  }
});
if(valid){
  nextStepWizard.removeClass('disabled').trigger('click');


}
// if any of the inputs are invalid we want to disrupt the click event
return valid;*/


var curStep = $(this).closest(".setup-content"),
curStepBtn = curStep.attr("id"),
nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
curInputs = curStep.find("input[type='text'],input[type='url']"),
isValid = true;

$(".form-group").removeClass("has-error");
for(var i=0; i<curInputs.length; i++){
  if (!curInputs[i].validity.valid){
    isValid = false;
    $(curInputs[i]).closest(".form-group").addClass("has-error");
  }
}


if (isValid){
  $("#errors").html("");
  nextStepWizard.removeClass('disabled').trigger('click');
}else{
  $("#errors").html("Ces champs sont obligatoires");
}
});


allBackBtn.click( function(){
 var curStep = $(this).closest(".setup-content"),
 curStepBtn = curStep.attr("id"),
 previousStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().prev().children("a");
 previousStepWizard.trigger('click');
});
$('div.setup-panel div a.btn-primary').trigger('click');




})
$( document ).ready(function() {



});