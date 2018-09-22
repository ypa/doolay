
$(document).ready(function() {
    // $("#booking").datepicker(); jquery datepicker

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

    // disable the booking button by default.
	$("#booking-request").addClass('disabled');

    // set active on calendar date.
    $(".calendar-body .date-item").click(function() {
        $(".calendar-body .date-item").removeClass('active');
        $(this).addClass('active');
	    $("#booking-request").removeClass('disabled'); // now enable the button
    });

    // populate modal
    $("#booking-request").click(function() {
        var selectedDate = $(".date-item.active").attr("value");
        // populate date field and disable
        $("#booking-date").val(selectedDate);
        $("#booking-date").prop('disabled', true);

        var slotId = $(".date-item.active").attr("slot");
        var requestUrl = "/bookings/request/" + slotId + '/';
        $("#booking_request_form").attr('action', requestUrl);
    });
});