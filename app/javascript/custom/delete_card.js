$(document).on("click", ".deleteRow", function(e) {
    e.preventDefault();
    $(this).parents(".form-group").hide();
    $(this).siblings("input").val(true);
});