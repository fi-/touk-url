$("#url-form").submit(function( event ) {
  event.preventDefault();
  console.log( "default prevented!" )
});

$( ".upload" ).click(function() {
  var  uploadurl = '{' + '\"url\":' + '\"' + $("#uploadurl").val() + '\"' + '}';
  $.ajax({
      url : "http://localhost:3000/",
      type: "POST",
      data : uploadurl,
      dataType: "json",
      success: function(data){
        if(data.length == 0) {
          console.log( "nothing found!" );
        }
        else {

        console.log( "found something!" );

        $("#resultarea").addClass("visible")
        $("#url-form").addClass("down")
        $("#url1").text(data.funEncoded);
        $("#url1").prop("href", data.funEncoded)
        $("#url2").text(data.classyEncoded);
        $("#url2").prop("href", data.classyEncoded)
        ;
      }
      }
  });
});


$( document ).ready(function() {
    console.log( "ready!" );
});
