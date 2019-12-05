$(document).on('turbolinks:load', function(){
    $( "#importCSV" ).click(function(e) {
        e.preventDefault();
        $("#file").click();
    });

    $(document).on("change", "#file", function () {
        const form = document.getElementById("uploadFile");
        form.dispatchEvent(new Event('submit', {bubbles: true}));
    })

});