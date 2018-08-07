
$(document).ready(function() {
    $("#booking").datepicker();

    // show this month calendar and hide the next one
    $("#next-month-calendar").hide();
    $("#this-month-calendar").show();

    // toggle between this month and next month calendars
    $("#this-month-calendar .btn-right").click(function() {
  		$("#this-month-calendar").hide();
  		$("#next-month-calendar").show();
	});

    $("#next-month-calendar .btn-left").click(function() {
  		$("#next-month-calendar").hide();
  		$("#this-month-calendar").show();
	});
});