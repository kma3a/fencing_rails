
  var participantNode = "<li><input type='text' name='event[participants][]'><button class='remove-button'>X</button></li>"

$(document).ready(function(){
  

$('#new_event').on('click','.add_participant', function(event){
  event.preventDefault();
  $($(this).siblings(' ol')).append(participantNode);
});

$('#new_event').on('click','.remove-button', function(event){
  event.preventDefault();
  $(this).parent().remove();
});



});
