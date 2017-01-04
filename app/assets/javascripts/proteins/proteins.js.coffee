# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $('#proteins').dataTable({
        sPaginationType: "bootstrap"
        bProcessing: true
        bServerSide: true
        sAjaxSource: $('#products').data('source')
        oLanguage: {
            sSearch: "Find Protein ID, Name or Taxon:"
            sInfo: "Showing _START_ to _END_ of _TOTAL_ proteins"
            sLengthMenu: "Show _MENU_ proteins per page"
        }
        
    });
#    bJQueryUi: true
#    bProcessing:true

