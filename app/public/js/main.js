jQuery(document).ready(function($) {

  $(function() {
    $(".radio input").click(function() {
      $(".radio input").removeAttr("checked")
      // $(this).attr("checked", true)
    });
  });

})
