$(document).on('turbolinks:load', function () {
    $(".input-answer").one('focus', function (e) {
        let inputWord = $(this).closest(".card-form-row").find(".input-question").val();
        $("#keyword").val(inputWord);
        $("#cardRowId").val($(this).closest(".card-form-row").attr('id'));
        document.getElementById("searchKeyword").dispatchEvent(new Event('submit', {bubbles: true}));
    });

    $(document).on("click", ".suggest-word", function (e) {
        e.preventDefault();
        $(this).parent().siblings(".input-answer").val($.trim($(this).text()));
        $(this).parent().html("");
        $(this).parent().hide();
    })
});