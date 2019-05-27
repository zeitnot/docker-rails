//= require jquery3
//= require bootstrap

$(document).ready(function () {
    $('.panel-heading').on('click', function () {
        $(this).siblings('.poll-options').toggle()
    })
})