$(document).on('turbolinks:load', function(){
    $( "#uploadUserFile" ).click(function(e) {
        e.preventDefault();
        $("#user_image").click();
    });

    $(document).on("change", "#user_image", function () {
        let filename = document.getElementById("user_image").files[0].name;;
        $("#uploadFileHelperText").text(filename)
    })
});