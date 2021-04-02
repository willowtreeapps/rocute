'''''''''
' init: initializes the DatePicker component.
' 
'''''''''
sub init()
    m.year = m.top.findNode("year")
    m.month = m.top.findNode("month")
    m.day = m.top.findNode("day")
    m.year.content = getYearContents()
    m.month.content = getMonthContents()
    m.day.content = getDayContents()
    m.year.itemSize = [m.top.yearWidth, 50]
    m.month.itemSize = [m.top.monthWidth, 50]
    m.day.itemSize = [m.top.dayWidth, 50]
    setFormat()
    m.top.observeField("focusedChild", "giveFocus")
end sub

'''''''''
' setDate: This method populates the interface fields "dateTimeISOString" and "dateTimeSeconds"
' 
'''''''''
sub setDate()
    yearIndex = m.year.itemFocused
    monthIndex = m.month.itemFocused
    dayIndex = m.day.itemFocused
    if yearIndex <= 0 or monthIndex <= 0 or dayIndex <= 0 then
        m.top.dateTimeISOString = ""
        m.top.dateTimeSeconds = 0
        return
    end if

    yearString = m.year.content.getChild(yearIndex).title
    monthString = getTwoDigitString(monthIndex)
    dayString = getTwoDigitString(dayIndex)

    isoString = yearString + "-" + monthString + "-" + dayString + "T00:00:00"
    dateTime = createObject("roDateTime")
    offsetStr = getOffsetString(dateTime)
    isoString = isoString + offsetStr
    dateTime.fromISO8601String(isoString)
    m.top.dateTimeISOString = dateTime.toISOString()
    m.top.dateTimeSeconds = dateTime.asSeconds()
end sub

'''''''''
' getOffsetString: a function to get the appropriate timezone offset string in the ISO format. Currently Roku does not support anything other than UTC, so UTC is always returned. 
' 
' @param {object} dateTime a roDateTime object
' @return {string} the timezone offset as a string: "Z" for UTC offset
'''''''''
function getOffsetString(dateTime as object) as string
    return "Z"
    ' in the event that this is ever supported, delete the above line and uncomment code below
    ' offset = -dateTime.getTimeZoneOffset() ' have to negate this because roku returns the wrong thing. 
    ' offsetHours = offset \ 60
    ' offsetMins = abs(offset) mod 60
    ' offsetStr = getTwoDigitString(offsetHours) + ":" + getTwoDigitString(offsetMins)
    ' if offsetHours > 0 then
    ' offsetStr = "+" + offsetStr
    ' else if offsetHours < 0 and left(offsetStr, 1) <> "-" then ' this should only happen if the offset is -30 minutes, which is probably not a real timezone but you never know, it could be someday.
    ' offsetStr = "-" + offsetStr
    ' end if
    ' return offsetStr
end function

'''''''''
' getTwoDigitString: a function to get a (at least) two digit string from an integer. (example: 1 would return "01"). If the number is negative, returns a negative sign in front of the number. (example: -1 would return "-01").
' 
' @param {integer} number any integer
' @return {string} a string representation of that number, padded to at least 2 digits.
'''''''''
function getTwoDigitString(number as integer) as string
    numStr = stri(number, 10)
    if len(numStr) < 2 then
        numStr = "0" + numStr
    else if number < 0 and len(numStr) < 3 then
        numStr = "-0" + right(numStr, 1)
    end if
    return numStr
end function

'''''''''
' giveFocus: a helper method to handle focus.
' 
' @param {object} event
'''''''''
sub giveFocus(event as object)
    if m.top.hasFocus() and m.firstPicker.isInFocusChain() = false and m.secondPicker.isInFocusChain() = false and m.thirdPicker.isInFocusChain() = false then
        m.firstPicker.setFocus(true)
    end if
end sub

'''''''''
' setFormat: Sets the order of the datePickers according to the date format.
' 
'''''''''
sub setFormat()
    dateOrder = "YMD"
    if m.top.useISO = false then
        ' use location specific order
        dateOrder = tr("MDY")
    end if

    m.month.unobserveField("itemFocused")
    m.year.unobserveField("itemFocused")

    ' YMD, MDY, and DMY are the only formats acceptable. things like "MYD" or any other invalid string will fall back to the ISO standard of "YMD".
    if dateOrder = "MDY" then
        m.month.translation = [0,50]
        m.day.translation = [m.top.monthWidth + 50, 50]
        m.year.translation = [m.top.monthWidth + m.top.dayWidth + 100, 50]
        m.firstPicker = m.month
        m.secondPicker = m.day
        m.thirdPicker = m.year
    else if dateOrder = "DMY" then
        m.day.translation = [0,50]
        m.month.translation = [m.top.dayWidth + 50, 50]
        m.year.translation = [m.top.monthWidth + m.top.dayWidth + 100, 50]
        m.firstPicker = m.day
        m.secondPicker = m.month
        m.thirdPicker = m.year
    else ' fall back to ISO standard, "YMD"
        m.year.translation = [0, 50]
        m.month.translation = [m.top.yearWidth + 50, 50]
        m.day.translation = [m.top.yearWidth + m.top.monthWidth + 100, 50]
        m.firstPicker = m.year
        m.secondPicker = m.month
        m.thirdPicker = m.day
    end if

    m.year.observeField("itemFocused", "yearChanged")
    m.month.observeField("itemFocused", "monthChanged")
    m.day.observeField("itemFocused", "dayChanged")
end sub

'''''''''
' yearChanged: a method called when the year changes. This checks if we have february selected as the month and changes the number of days if we are in a leap year
' 
' @param {object} event a roSGNodeEvent
'''''''''
sub yearChanged(event as object)
    if m.year.hasFocus() = false then return
    if m.month.itemFocused <> 2 then 
        setDate()
        return
    end if
    index = event.getData()
    selectedYear = val(m.year.content.getChild(index).title, 10)
    numDays = m.day.content.getChildCount() - 1 ' subtract 1 for the blank day
    isLeap = isLeapYear(selectedYear)
    if (isLeap = false and numDays <> 28) or (isLeap = true and numDays <> 29) then
        updateDayContents()
    end if
    setDate()
end sub

'''''''''
' updateDayContents: This method updates the number of days in the month appropriately according to what month and year it is. It preserves which day was selected, except in the case where the selected day does not exist in this month and year, in which case it reverts to the blank selection option.
' 
'''''''''
sub updateDayContents()
    selectedDay = m.day.itemFocused
    dayContents = getDayContents()
    m.day.content = dayContents
    if selectedDay < m.day.content.getChildCount() then
        m.day.unobserveField("itemFocused")
        m.day.jumpToItem = selectedDay
        m.day.observeField("itemFocused", "dayChanged")
    end if
end sub

' a method called when the month changes. This populates the correct number of days into the day list.
'
' @param event a roSGNodeEvent
sub monthChanged(event as object)
    if m.month.hasFocus() = false then return
    selectedMonth = event.getData()
    oldNumDays = m.day.content.getChildCount() - 1 ' subtract 1 for the blank day
    newNumDays = 31
    if selectedMonth = 9 or selectedMonth = 4 or selectedMonth = 6 or selectedMonth = 11 ' 30 days hath september, april, june, and november
        newNumDays = 30
    else if selectedMonth = 2 then
        index = m.year.itemFocused
        if index < 1 then
            newNumDays = 28
        else
            selectedYear = val(m.year.content.getChild(index).title, 10)
            if isLeapYear(selectedYear) then
                newNumDays = 29
            else
                newNumDays = 28
            end if
        end if
    end if

    if oldNumDays <> newNumDays then
        updateDayContents()
    end if
    setDate()
end sub

' a method called when the day changes.
sub dayChanged(event as object)
    if m.day.hasFocus() = false then return
    setDate()
end sub

' a method to turn month names on or off
'
' @param event a roSGNodeEvent
sub toggleMonthNames(event as object)
    selectedMonth = m.month.itemFocused
    m.month.content = getMonthContents()
    m.month.unobserveField("itemFocused")
    m.month.itemFocused = selectedMonth
    m.month.observeField("itemFocused", "monthChanged")
end sub

' a function which returns a ContentNode with 150 years in it, starting with this year
'
' @return a ContentNode with the appropriate year data
function getYearContents() as object
    years = createObject("roSGNode", "ContentNode")
    blank = years.createChild("ContentNode")
    blank.title = ""

    dateTime = createObject("roDateTime")
    currentYear = dateTime.getYear()
    for i = currentYear to currentYear - 150 step -1
        year = years.createChild("ContentNode")
        year.title = stri(i, 10)
    end for

    return years
end function

' a function which returns the ContentNode with the appropriate month data.
'
' @return a ContentNode with the appropriate month data
function getMonthContents() as object
    months = createObject("roSGNode", "ContentNode")
    blank = months.createChild("ContentNode")
    blank.title = ""
    
    if m.top.useMonthNames = true then
        january = months.createChild("ContentNode")
        january.title = tr("January")
        february = months.createChild("ContentNode")
        february.title = tr("February")
        march = months.createChild("ContentNode")
        march.title = tr("March")
        april = months.createChild("ContentNode")
        april.title = tr("April")
        may = months.createChild("ContentNode")
        may.title = tr("May")
        june = months.createChild("ContentNode")
        june.title = tr("June")
        july = months.createChild("ContentNode")
        july.title = tr("July")
        august = months.createChild("ContentNode")
        august.title = tr("August")
        september = months.createChild("ContentNode")
        september.title = tr("September")
        october = months.createChild("ContentNode")
        october.title = tr("October")
        november = months.createChild("ContentNode")
        november.title = tr("November")
        december = months.createChild("ContentNode")
        december.title = tr("December")
    else
        for i = 1 to 12
            month = months.createChild("ContentNode")
            month.title = stri(i, 10)
        end for
    end if

    return months
end function

' a function which returns the ContentNode with the appropriate day data. It takes into account how many days the selected month has and whether or not the selected year is a leap year. If no month is selected, defaults to 31 days. If no year is selected, defaults to not a leap year.
'
' @return a ContentNode with the appropriate day data
function getDayContents() as object
    days = createObject("roSGNode", "ContentNode")
    blank = days.createChild("ContentNode")
    blank.title = ""

    currentMonth = 0
    if m.month <> invalid and m.month.itemFocused <> invalid
        currentMonth = m.month.itemFocused
    end if

    numDays = 31 ' default to 31 days
    if currentMonth = 2 ' February has an unusual number of days, handle this case differently
        currentYear = 0
        if m.year <> invalid then
            currentYear = m.year.itemFocused
        end if

        if isLeapYear(currentYear) then
            numDays = 29
        else
            numDays = 28
        end if
    else if currentMonth = 9 or currentMonth = 4 or currentMonth = 6 or currentMonth = 11 ' 30 days hath september, april, june, and november
        numDays = 30
    end if

    for i = 1 to numDays
        day = days.createChild("ContentNode")
        day.title = stri(i)
    end for

    return days
end function

'''''''''
' isLeapYear: function to check if a year is a leap year according to the Gregorian Calendar.
' 
' @param {integer} year the year to check
' @return {boolean} true if the year is a leap year, false otherwise
'''''''''
function isLeapYear(year as integer) as boolean
    if year mod 4 <> 0 then return false ' years not divisible by 4 are not leap years. ex: 1999
    if year mod 100 <> 0 then return true ' years divisible by 4 and not divisible by 100 are leap years, ex: 1996
    if year mod 400 = 0 then return false ' years divisible by 400 are NOT leap years, ex: 2000
    return true ' years divisible by 4 and 100 but not 400 are leap years, ex: 1900
end function

'''''''''
' onKeyEvent: a function to handle key press events and give focus as needed
' 
' @param {string} key a string representing the key pressed
' @param {boolean} press a boolean representing whether this was a press (true) or release (false)
' @return {boolean} a boolean representing whether this key event was handled here (true) or it should bubble up (false)
'''''''''
function onKeyEvent(key as string, press as boolean) as boolean
    if m.top.isInFocusChain() = false or press = false then return false

    if key = "left" or key = "back" then
        if m.thirdPicker.hasFocus() then
            m.secondPicker.setFocus(true)
            return true
        else if m.secondPicker.hasFocus() then
            m.firstPicker.setFocus(true)
            return true
        end if
    else if key = "right" then
        if m.firstPicker.hasFocus() then
            m.secondPicker.setFocus(true)
            return true
        else if m.secondPicker.hasFocus() then
            m.thirdPicker.setFocus(true)
            return true
        end if
    end if
    return false
end function