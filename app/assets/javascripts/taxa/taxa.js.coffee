# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('#taxa-proteins').dataTable({
        sPaginationType: "bootstrap"
        bProcessing: true
        bServerSide: true
        sAjaxSource: $('#taxa').data('source')
        oLanguage: {
            sSearch: "Find proteins by id or name:"
            sInfo: "Showing _START_ to _END_ of _TOTAL_ proteins"
            sLengthMenu: "Show _MENU_ proteins per page"
        }
        
    });
    $('#taxa').dataTable({
        sPaginationType: "bootstrap"
        bProcessing: true
        bServerSide: true
        sAjaxSource: $('#taxa').data('source')
        aoColumns: [
            null,
            null,
            { bSortable: false }
        ]
        oLanguage: {
            sSearch: "Find species:"
            sInfo: "Showing _START_ to _END_ of _TOTAL_ Species"
            sLengthMenu: "Show _MENU_ species per page"
        }
        
    });
