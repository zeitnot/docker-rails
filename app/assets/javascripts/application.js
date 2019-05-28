//= require jquery3
//= require bootstrap
//= require rails-ujs

$(document).ready(function () {
    $(document).on('click','.panel-heading',function () {
        $(this).siblings('.poll-options').toggle()
    })
})