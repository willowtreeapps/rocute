' initializes the DatePicker component.
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

' a function to handle key press events and give focus as needed
'
' @param key a string representing the key pressed
' @param press a boolean representing whether this was a press (true) or release (false)
' @return a boolean representing whether this key event was handled here (true) or it should bubble up (false)
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

' a helper method to handle focus.
sub giveFocus(event as object)
    if m.top.isInFocusChain() and m.firstPicker.hasFocus() = false and m.secondPicker.hasFocus() = false and m.thirdPicker.hasFocus() = false then
        m.firstPicker.setFocus(true)
    end if
end sub

' Sets the order of the datePickers according to the date format.
sub setFormat()
    dateOrder = "YMD"
    if m.top.useISO = false then
        ' use location specific order
        dateOrder = tr("MDY")
    end if

    m.month.unobserveField("itemSelected")
    m.year.unobserveField("itemSelected")

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

    m.year.observeField("itemSelected", "yearChanged")
    m.month.observeField("itemSelected", "monthChanged")
end sub

' a method called when the year changes. This checks if we have february selected as the month and changes the number of days if we are in a leap year
'
' @param event a roSGNodeEvent
sub yearChanged(event as object)
    if m.month.itemSelected <> 2 then return
    index = event.getData()
    selectedYear = val(m.year.content.getChild(index).title, 10)
    numDays = m.day.content.getChildCount() - 1 ' subtract 1 for the blank day
    isLeap = isLeapYear(selectedYear)
    if (isLeap = false and numDays <> 28) or (isLeap = true and numDays <> 29) then
        updateDayContents()
    end if
end sub

sub updateDayContents()
    selectedDay = m.day.itemSelected
    dayContents = getDayContents()
    m.day.content = dayContents
    if selectedDay < m.day.content.getChildCount() then
        m.day.jumpToItem(selectedDay)
    end if
end sub

' a method called when the month changes. This populates the correct number of days into the day list.
'
' @param event a roSGNodeEvent
sub monthChanged(event as object)
    selectedMonth = event.getData()
    oldNumDays = m.day.content.getChildCount() - 1 ' subtract 1 for the blank day
    newNumDays = 31
    if selectedMonth = 9 or selectedMonth = 4 or selectedMonth = 6 or selectedMonth = 11 ' 30 days hath september, april, june, and november
        newNumDays = 30
    else if selectedMonth = 2 then
        index = m.year.itemSelected
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
end sub

' a method to turn month names on or off
'
' @param event a roSGNodeEvent
sub toggleMonthNames(event as object)
    selectedMonth = m.month.itemSelected
    m.month.content = getMonthContents()
    m.month.itemSelected = selectedMonth
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
        year.title = stri(i)
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
    deviceInfo = createObject("roDeviceInfo")
    print deviceInfo.getCurrentLocale()
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
            month.title = stri(i)
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
    if m.month <> invalid and m.month.itemSelected <> invalid
        currentMonth = m.month.itemSelected
    end if

    numDays = 31 ' default to 31 days
    if currentMonth = 2 ' February has an unusual number of days, handle this case differently
        currentYear = 0
        if m.year <> invalid then
            currentYear = m.year.itemSelected
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

' function to check if a year is a leap year according to the Gregorian Calendar.
'
' @param year the year to check
' @return boolean true if the year is a leap year, false otherwise
function isLeapYear(year as integer) as boolean
    if year mod 4 <> 0 then return false ' years not divisible by 4 are not leap years. ex: 1999
    if year mod 100 <> 0 then return true ' years divisible by 4 and not divisible by 100 are leap years, ex: 1996
    if year mod 400 = 0 then return false ' years divisible by 400 are NOT leap years, ex: 2000
    return true ' years divisible by 4 and 100 but not 400 are leap years, ex: 1900
end function

function getDate() as string
    dateTime = createObject("roDateTime")
    print dateTime
    return dateTime.toISOString()
end function