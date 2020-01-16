' Initialization method for the Clock component
sub init()
    info = createObject("roDeviceInfo")
    m.clockFormat = info.getClockFormat()
    m.dateTime = createObject("roDateTime")
    m.dateTime.toLocalTime()
    m.displayLabel = m.top.findNode("timeLabel")

    m.displayLabel.font = "font:MediumSystemFont"
    m.displayLabelFont = m.displayLabel.font

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
    updateClock()
end sub

'Update font
'@param event a roSGNodeEvent
sub onDisplayLabelFontChanged(event as Object)
    fontUrl = event.getData()
    m.displayLabelFont.uri = fontUrl
    m.displayLabelFont.size = m.top.fontSize
end sub

'Update font size
'@param event a roSGNodeEvent
sub onDisplayLabelFontSizeChanged(event as Object)
    fontSize = event.getData()
    m.displayLabelFont.size = fontSize
end sub

' Updates the label with the correct time
sub updateClock()
    m.dateTime.mark()
    m.dateTime.toLocalTime()
    m.displayLabel.text = getTimeString()
end sub

' A function to get a string representation of m.dateTime in the appropriate format.
'
' @return the time as a string
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

' A function to return a string version of a number with no spaces and at least two digits, padded with zeros if necessary.
'
' @param number any integer
' @return a string representation of that number
function toDoubleDigits(number as integer) as string
    numString = toSimpleString(number)
    length = len(numString)

    if length = 2 then
        return numString
    else
        return "0" + numString
    end if
end function

' A function to return a string version of a number with no spaces
'
' @param number any integer
' @return a string representation of that number
function toSimpleString(number as integer) as string
    numString = stri(number)
    length = len(numString)
    return right(numString, length - 1) ' chop off the extra space roku's stri function adds to the front
end function

' A method to check if we've reached the top of the minute, and if so, start the timer which goes off every 60 seconds.
'
' @param event a roSGNodeEvent
sub delayToStartOfMinute(event as object)
    m.dateTime.mark()
    m.dateTime.toLocalTime()
    second = m.dateTime.getSeconds()
    if second = 0 then
        updateClock()
        m.timer.control = "start"
        m.delayTimer = invalid
    end if
end sub