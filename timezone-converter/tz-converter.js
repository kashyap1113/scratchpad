var SQL_TIME_FORMAT = 'YYYY-MM-DD HH:mm:ss';
$(document).on('blur paste', '#millis', function() {
    console.log('input time added');
});


$(document).on('change', '.output-timezone', function() {
    console.log('timezone dropwon changed');
});


