//= require jquery3
//= require bootstrap
//= require rails-ujs

$(document).ready(function () {
    $('.panel-heading').on('click', function () {
        $(this).siblings('.poll-options').toggle()
    })
})