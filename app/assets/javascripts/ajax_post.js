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
          var result_url = location.href + data.tamaki_url
          $("#result textarea").val(result_url);
          
          $('#result iframe').remove(); //分岐せずにremoveする  すこしダーティ
          $('#result').append(' <a href="https://twitter.com/share" class="twitter-share-button" data-url="" data-text="ttp://tamakiep.com/'+ data.tamaki_url +'/" data-lang="ja" data-size="large" data-count="none" data-hashtags="tamaki_url">ツイート</a>');//完全に邪悪
          twttr.widgets.load();
          $("#result").slideDown("slow");
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