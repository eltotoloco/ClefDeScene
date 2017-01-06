ClientSideValidations.formBuilders['NestedForm::Builder'] = ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'];
ClientSideValidations.formBuilders['BootstrapForm::Builder'] = ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'];


window.ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'] = {
  add: function(element, settings, message) {
    // custom add code here
    debugger;
  },

  remove: function(element, settings) {
    // custom remove code here
  }
}
$('form').on('nested:fieldAdded', function(event) {
	console.log("bouyah");
  $(event.target).find(':input').enableClientSideValidations();
});