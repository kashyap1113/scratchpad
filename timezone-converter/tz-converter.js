var SQL_TIME_FORMAT = 'YYYY-MM-DD HH:mm:ss';
$(document).ready(function() {
    fillTimeZone('.output-timezone');
    fillTimeZone('.to-timezone');
});
$(document).on('blur paste', '.millis', function(event) {
    var inputTime = event.type == 'paste' 
        ? event.originalEvent.clipboardData.getData('text/plain')
        : $('.millis').val();
    var tz = $('.output-timezone').val();
    convertMillisToTimeZone(inputTime, tz);
    $('.to-timezone').trigger('change');
});


$(document).on('change', '.output-timezone', function(event) {
    var tz = $('.output-timezone').val();
    convertMillisToTimeZone($('.millis').val(), tz);
    $('.to-timezone').trigger('change');
});

$(document).on('change', '.to-timezone', function(event) {
    var tz = $('.to-timezone').val();
    convertTimeZoneToMillis($('.formatted').val(), tz);
});

function convertMillisToTimeZone(millis, timeZone) {
    if (millis == '')
        return;
    var mmt = moment.tz(millis, 'x', timeZone); 
    var formatted = mmt.format(SQL_TIME_FORMAT)
    $('.formatted').val(formatted);
}

function convertTimeZoneToMillis(sqlTime, timeZone) {
    if (sqlTime == '')
        return;
    var mmt = moment.tz(sqlTime, SQL_TIME_FORMAT, timeZone);
    $('.converted-millis').val(mmt.format('x'));
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
