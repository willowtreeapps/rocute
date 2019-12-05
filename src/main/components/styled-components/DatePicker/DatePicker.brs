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

' a helper method to handle focus.
sub giveFocus(event as object)
    if m.top.isInFocusChain() then
        print event.getData().id
        data = event.getData()
        if m.year.hasFocus() = false and m.month.hasFocus() = false and m.day.hasFocus() = false then
            m.firstPicker.setFocus(true)
        else if event.getData().id = m.secondPicker.id then
            m.secondPicker.setFocus(true)
        else
            m.thirdPicker.setFocus(true)
        end if
    end if
end sub

' Sets the order of the datePickers according to the date format.
'
' @param event a roSGNodeEvent. This parameter is optional.
sub setFormat()
    dateOrder = "YMD"
    if m.top.useISO = false then
        ' use location specific order
        dateOrder = tr("MDY")
    end if

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
end sub

sub toggleMonthNames(event as object)
    selectedMonth = m.month.selectedIndex
    m.month.content = getMonthContents()
    m.month.selectedIndex = selectedIndex
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
    if m.month <> invalid and m.month.selectedIndex <> invalid
        currentMonth = m.month.selectedIndex
    end if

    numDays = 31 ' default to 31 days
    if currentMonth = 2 ' February has an unusual number of days, handle this case differently
        currentYear = 0
        if m.year <> invalid then
            currentYear = m.year.selectedIndex
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

' function to check if a year is a leap year
'
' @param year the year to check
' @return boolean true if the year is a leap year, false otherwise
function isLeapYear(year as integer) as boolean
    ' TODO: do something here.
    return false
end function
