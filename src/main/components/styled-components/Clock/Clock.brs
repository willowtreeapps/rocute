sub init()
    info = createObject("roDeviceInfo")
    m.clockFormat = info.getClockFormat()
    m.dateTime = createObject("roDateTime")
    m.dateTime.toLocalTime()
    m.displayLabel = m.top.findNode("timeLabel")

    ' set the timer to update the clock every minute.
    m.timer = m.top.findNode("minuteTimer")
    m.timer.observeField("fire", "updateClock")
    
    ' TODO: we could delay to start of second before doing this but it's not very necessary
    ' don't start the minute timer until we reach the top of the minute.
    ' in order to do this, check every second if we're at the top of the minute yet.
    m.delayTimer = createObject("roSGNode", "Timer")
    m.delayTimer.repeat = true
    m.delayTimer.observeField("fire", "delayToStartOfMinute")
    m.delayTimer.control = "start"

    ' show the current time
    updateClock(invalid)
end sub

sub updateClock(event as object)
    m.dateTime.mark()
    m.dateTime.toLocalTime()
    m.displayLabel.text = getTimeString()
end sub

function getTimeString() as string
    hours = m.dateTime.getHours()
    minutes = m.dateTime.getMinutes()
    minuteString = toDoubleDigits(minutes)
    hourString = toDoubleDigits(hours) ' default to 24 hour format
    ampm = ""
    if m.clockFormat <> "24h" then
        ' do 12 hour format by default
        if hours < 12 then
            ampm = " am"
        else
            ampm = " pm"
        end if
        if hours > 12 then
            hours -= 12
        else if hours = 0 then
            hours = 12
        end if
        hourString = toSimpleString(hours)
    end if
    return hourString + ":" + minuteString + ampm
end function

function toDoubleDigits(number as integer) as string
    numString = toSimpleString(number)
    length = len(numString)

    if length = 2 then
        return numString
    else
        return "0" + numString
    end if
end function

function toSimpleString(number as integer) as string
    numString = stri(number)
    length = len(numString)
    return right(numString, length - 1) ' chop off the extra space roku's stri function adds to the front
end function

sub delayToStartOfMinute(event as object)
    m.dateTime.mark()
    m.dateTime.toLocalTime()
    second = m.dateTime.getSeconds()
    if second = 0 then
        updateClock(invalid)
        m.timer.control = "start"
        m.delayTimer = invalid
    end if
end sub