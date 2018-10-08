
function closeModal() {
    // todo: WIP..
    // $("#booking_request_form .modal-footer a.btn.btn-link").trigger('click'); // does this work? 10/07/2018
    window.location.search += '#booking-overlay';
}


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
        $("#request_date").val(selectedDate);
        $("#request_date").prop('disabled', true);

        var slotId = $(".date-item.active").attr("slot");
        var requestUrl = "/api/bookings/" + slotId + '/request/';
        $("#booking_request_form").attr('action', requestUrl);
    });


    // submit the form
    $('#booking_request_form').on('submit', function () {
        const bookingRequest = {
            'request_date': $('#request_date').val(),
            'first_name': $('#first_name').val(),
            'last_name': $('#last_name').val(),
            'email_address': $('#email_address').val(),
            'group_size': $('#group_size').val(),
            'notes': $('#notes').val()
        };

        $.ajax({
            url: $('#booking_request_form').attr('action'),
            type: 'POST',
            accepts: 'application/json',
            contentType: 'application/json',
            data: JSON.stringify(bookingRequest),
            success: function (result) {
                closeModal();
            }
        });
        return false;

    });


});