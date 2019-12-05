$(document).on('turbolinks:load', function () {
    $(document).on("focus", ".input-answer", function (e) {
        if($(this).data('notFirstFocused') !== true){
            $(this).data('notFirstFocused', true);
            let inputWord = $(this).closest(".card-form-row").find(".input-question").val();

            if(inputWord.trim()){
                $("#keyword").val(inputWord);
                $("#cardRowId").val($(this).closest(".card-form-row").attr('id'));
                document.getElementById("searchKeyword").dispatchEvent(new Event('submit', {bubbles: true}));
            }
        }
    });

    $(document).on("focusout", ".input-answer", function (e) {
        $(this).data('notFirstFocused', false);
    });



    $(document).on("click", ".suggest-word", function (e) {
        e.preventDefault();
        $(this).parent().siblings(".input-answer").val($.trim($(this).text()));
        $(this).parent().html("");
        $(this).parent().hide();
    })
});