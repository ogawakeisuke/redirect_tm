$(function(){

  $('.ajax_post').on('submit', function(e) {
    $this = $(this);
    $("#result").html('<img src="loading.gif" width="10" height="10" alt="Now Loading..." />');
    $.ajax({
      url: $(this).attr('action'),
      type: "POST",
      data : $(this).serialize(),
      error: function(){
        alert('sorry try again later...');
        return false;
      },
      success: function(data) {
//        $("#result").hide("slow");
        $("#result").text(location.href + data.tamaki_url).show("slow");
      }
    });
    return false;
  });

})