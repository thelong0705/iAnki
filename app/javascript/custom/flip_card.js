$(document).on('turbolinks:load', function(){
    $('.flip-card').click(function() {
        $('.flip-card-inner').toggleClass('flip');
    });
});