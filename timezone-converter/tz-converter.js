var SQL_TIME_FORMAT = 'YYYY-MM-DD HH:mm:ss';
$(document).on('blur paste', '#millis', function() {
    console.log('input time added');
});


$(document).on('change', '.output-timezone', function() {
    console.log('timezone dropwon changed');
    convertMillisToTimeZone($('#millis').val(), 'UTC+00:00');
});

function convertMillisToTimeZone(millis, timeZone) {
    var mmt = moment.tz(millis, 'x', timeZone); 
    console.log('converted time .....' + mmt.format(SQL_TIME_FORMAT));
}
