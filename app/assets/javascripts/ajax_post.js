$(function(){
  $('.ajax_post').on('submit', function(e) {
    $this = $(this);
//    $("#result").html('<img src="assets/loading.gif" width="10" height="10" alt="Now Loading..." />');
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
        if(data.result == 'OK'){
          $("#result textarea").val(location.href + data.tamaki_url);
          $("#result a data-url").val(location.href + data.tamaki_url);
          $("#result").show("slow");
          return false;
        };
        if(data.result == 'ERROR'){
           $("#result").hide();
          alert(data.tamaki_url);
          return false;
        };
      }
    });
    return false;
  });

  window.onload = function(){
    $("#result").hide();
  };
})