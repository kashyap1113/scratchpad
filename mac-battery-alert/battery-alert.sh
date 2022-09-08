#!/bin/sh
batteryPercentage=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
powerSource=$(pmset -g batt | head -n 1 | cut -d \' -f2)
batteryPower="Battery Power"
acPower="AC Power"
echo $batteryPercentage
echo $powerSource
if [ $batteryPercentage -lt 51 ] && [ "$powerSource" = "$batteryPower" ];
then
	osascript -e 'display dialog "Please, plug in the charger." buttons {"OK"} with icon caution'
elif [ $batteryPercentage -gt 90 ] && [ "$powerSource" = "$acPower" ];
then
	osascript -e 'display dialog "Please, unplug the charger." buttons {"OK"} with icon caution'
fi
exit 0