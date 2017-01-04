# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 
    $('#blastresults').dataTable(
        sPaginationType: "bootstrap"
    )


    $(".pop").each ->
      $this = $(this)
      $this.popover
        trigger: "hover"
        placement: "right"
        html: true
        content: $this.find(".popshow").html()

