$(document).ready(function () {
    let addNewRow = () => {
        let unique_id = + new Date();
        $(".card-form-row:last").parent().after(
            `
            <div class="form-group">
                <div class="row card-form-row" id="${unique_id}">
                    <div class="col-6">
                        <input class="form-control input-question" placeholder="Question" 
                        type="text" name="deck[cards_attributes][${unique_id}][question]" autocomplete: "off">
                    </div>
                    <div class="col-5">
                        <input class="form-control input-answer" placeholder="Answer" 
                        type="text" name="deck[cards_attributes][${unique_id}][answer]" autocomplete: "off">
                        <div class="suggest-answer" style="display: none;"></div>
                     </div>
                    <div class="col-1 float-right">
                        <input type="hidden" value="false" name="deck[cards_attributes][${unique_id}][_destroy]">
                        <button class="btn btn-danger btn-sm deleteRow">
                           <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
            </div>
            `
        );
        $(".card-form-row:last input:first").focus();
    }


    $(document).on("click", "#addCard", e => {
        e.preventDefault();
        addNewRow()
    });

    $(document).on("keydown", ".card-form-row .input-answer:last", e => {
        let code = e.keyCode || e.which;
        if (code === 9) {
            e.preventDefault();
            addNewRow()
        }
    });
})
