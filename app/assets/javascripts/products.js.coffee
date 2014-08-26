# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $("[data-behaviour~=datepicker]").datepicker(
  	todayBtn: "linked", 
  	todayHighlight: true, 
  	startDate: "(Time.current, :format => :datepicker)"
  	format: "yyyy/mm/dd"
  	)


$(document).on "page:change", ->
 $('.has_tooltip').tooltip()
 $('.has_top_tooltip').tooltip(placement: 'top')
 $('.has_bottom_tooltip').tooltip(placement: 'bottom')