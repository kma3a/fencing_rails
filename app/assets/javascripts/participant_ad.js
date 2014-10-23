
  var participantNode = "<li><input type='text' name='event[participants][]' placeholder='student key'><button class='remove-button'>X</button></li>"

$(document).ready(function(){
  
var count = 0;
$('#new_event').on('click', '.add-participant' , function(event){
  event.preventDefault();
  count ++;
  $($(this).siblings('ol')).append(participantNode);
  checkCount(count)
});

$('#new_event').on('click','.remove-button', function(event){
  event.preventDefault();
  count --;
  $(this).parent().remove();
  checkCount(count)
});
function checkCount(count) {
  if (count > 3) {
    $('.add-participant').hide();
  }else {
    $('.add-participant').show();
  }
}

});
