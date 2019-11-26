$(document).ready(function () {
    let addNewRow = () => {
        let unique_id = parseInt($(".card-form-row:last").attr('id')) + 1;
        $(".card-form-row:last").parent().after(
            `
            <div class="form-group">
              <div class="row card-form-row" id="${unique_id}">
                <div class="col">
                  <input class="form-control" placeholder="Question" type="text" name="deck[cards_attributes][${unique_id}][question]">
                </div>
                <div class="col">
                  <input class="form-control" placeholder="Answer" type="text" name="deck[cards_attributes][${unique_id}][answer]">
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

    $(document).on("keydown", ".card-form-row input:last", e => {
        let code = e.keyCode || e.which;
        if (code === 9) {
            e.preventDefault();
            addNewRow()
        }
    });
})