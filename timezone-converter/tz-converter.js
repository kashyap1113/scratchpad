var SQL_TIME_FORMAT = 'YYYY-MM-DD HH:mm:ss';
$(document).ready(function() {
    fillTimeZone('.output-timezone');
});
$(document).on('blur paste', '.millis', function(event) {
    var inputTime = event.type == 'paste' 
        ? event.originalEvent.clipboardData.getData('text/plain')
        : $('.millis').val();
    var tz = $('.output-timezone').val();
    convertMillisToTimeZone(inputTime, tz);
});


$(document).on('change', '.output-timezone', function(event) {
    var tz = $('.output-timezone').val();
    convertMillisToTimeZone($('.millis').val(), tz);
});

function convertMillisToTimeZone(millis, timeZone) {
    if (millis == '')
        return;
    var mmt = moment.tz(millis, 'x', timeZone); 
    console.log('converted time .....' + mmt.format(SQL_TIME_FORMAT));
    var formatted = mmt.format(SQL_TIME_FORMAT)
    $('.formatted').val(formatted);
}

var timeZoneList = [];
function getTimeZoneList() {
    timeZoneList = moment.tz.names();
}

function fillTimeZone(elementSelector) {
    if (timeZoneList.length == 0)
        getTimeZoneList();

    var optionEl;
    var selectEl = $(elementSelector);
    for (var i = 0; i < timeZoneList.length; i++) {
       optionEl = $('<option>', {
           value : timeZoneList[i],
           text : timeZoneList[i]
       }); 
       selectEl.append(optionEl);
    }
}
