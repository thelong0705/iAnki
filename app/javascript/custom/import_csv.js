$(document).on('turbolinks:load', function(){
    $( "#importCSV" ).click(function(e) {
        e.preventDefault();
        $("#file").click();
    });

    document.getElementById("file").onchange = function() {
        const form = document.getElementById("uploadFile");
        form.dispatchEvent(new Event('submit', {bubbles: true}));
    };
});