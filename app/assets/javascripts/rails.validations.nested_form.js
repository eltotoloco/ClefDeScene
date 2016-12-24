ClientSideValidations.formBuilders['NestedForm::Builder'] = ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'];
$('form').on('nested:fieldAdded', function(event) {
	console.log("bouyah");
  $(event.target).find(':input').enableClientSideValidations();
});