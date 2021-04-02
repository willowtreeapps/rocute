'@TestSuite DatePicker Unit Tests

'@BeforeEach
sub Date_Picker_create()
    m.datePicker = createObject("roSGNode", "DatePicker_TestLayer")
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the setDate function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test setDate sets an invalid date if any fields are not populated
sub Date_Picker_setDate_setsInvalidDates_givenUnpopulatedInputs()
    day = m.datePicker.findNode("day")
    day.setFocus(true)
    day.jumpToItem = 27
    month = m.datePicker.findNode("month")
    month.setFocus(true)
    month.jumpToItem = 8
    year = m.datePicker.findNode("year")
    year.setFocus(true)
    year.jumpToItem = 0

    m.datePicker.dateTimeIsoString = "some string"
    m.datePicker.dateTimeSeconds = 103020

    m.datePicker.callFunc("setDate")
    m.assertEqual(m.datePicker.dateTimeIsoString, "")
    m.assertEqual(m.datePicker.dateTimeSeconds, 0&)
end sub

'@Test setDate sets dateTimeIsoString and dateTimeSeconds
sub Date_Picker_setDate_setsDate_givenValidInputs()
    day = m.datePicker.findNode("day")
    day.setFocus(true)
    day.jumpToItem = 28
    month = m.datePicker.findNode("month")
    month.setFocus(true)
    month.jumpToItem = 4
    year = m.datePicker.findNode("year")
    year.setFocus(true)
    year.jumpToItem = 5

    m.datePicker.callFunc("setDate")

    ' this test will need to be updated yearly, or commented out
    m.assertEqual(m.datePicker.dateTimeIsoString, "2017-04-28T00:00:00Z")
    m.assertEqual(m.datePicker.dateTimeSeconds, 1493337600&)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the getOffsetString function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns Z
sub Date_Picker_getOffsetString_Returns_Z()
    dateTime = createObject("roDateTime")
    actual = m.datePicker.callFunc("getOffsetString", dateTime)
    m.AssertEqual("Z", actual)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the getTwoDigitString function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns the correct value
'@Params[0, "00"]
'@Params[1, "01"]
'@Params[10, "10"]
'@Params[100, "100"]
'@Params[-1, "-01"]
'@Params[-23, "-23"]
'@Params[-123, "-123"]
sub Date_Picker_getTwoDigitString_Returns_TwoDigitString(value as integer, expected as string)
    actual = m.datePicker.callFunc("getTwoDigitString", value)
    m.AssertEqual(expected, actual)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the giveFocus function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test the first picker is given focus
sub Date_Picker_giveFocus_focusesFirstPicker_givenNoneAreFocused()
    m.datePicker.useISO = true
    firstPicker = m.datePicker.findNode("year")
    m.assertFalse(firstPicker.isInFocusChain())
    m.datePicker.setFocus(true)
    m.assertTrue(firstPicker.isInFocusChain())
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the setFormat function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test setFormat orders the pickers appropriately according to our local language settings. The other test cases are ignored.
'@Params[true, "YMD", "year", "month", "day"]
'@Params[false, "DMY", "day", "month", "year"]
'@Params[false, "MDY", "month", "day", "year"]
sub Date_Picker_setFormat_ordersPickers(useISOFormat as boolean, format as string, firstPickerId as string, secondPickerId as string, thirdPickerId as string)
    m.datePicker.useIso = useISOFormat
    m.datePicker.callFunc("setFormat")
    dateOrder = m.datePicker.callFunc("getDateOrder")
    if dateOrder <> format then return
    firstPicker = m.datePicker.findNode(firstPickerId)
    secondPicker = m.datePicker.findNode(secondPickerId)
    thirdPicker = m.datePicker.findNode(thirdPickerId)
    m.assertTrue(firstPicker.translation[0] < secondPicker.translation[0])
    m.assertTrue(secondPicker.translation[0] < thirdPicker.translation[0])
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the yearChanged function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test yearChanged updates days in the month only for leap years in february
'@Params["2020", 2, 29]
'@Params["2020", 3, 31]
'@Params["2019", 2, 28]
'@Params["2019", 3, 31]
sub Date_Picker_yearChanged_updatesDays_onlyInFebruaryOfALeapYear(yearTitle as string, monthIndex as integer, dayCount as integer)
    m.datePicker.useIso = true
    monthPicker = m.datePicker.findNode("month")
    monthPicker.setFocus(true)
    monthPicker.jumpToItem = monthIndex

    yearPicker = m.datePicker.findNode("year")
    yearIndex = -1
    for i = 0 to yearPicker.content.getChildCount()-1 step 1
        if yearPicker.content.getChild(i).title = yearTitle then
            yearIndex = i
            exit for
        end if
    end for
    ' if given year is not in our picker, then return
    if yearIndex = -1 then return

    yearPicker.setFocus(true)
    yearPicker.jumpToItem = yearIndex

    dayPicker = m.datePicker.findNode("day")
    actualDayCount = dayPicker.content.getChildCount() - 1
    m.assertEqual(actualDayCount, dayCount)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the updateDayContents function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test updateDayContents jumps to the appropriate day when the month changes
'@Params["2021", 27, 10, 27]
'@Params["2021", 29, 10, 29]
'@Params["2021", 30, 10, 30]
'@Params["2021", 31, 10, 31]
'@Params["2021", 27, 4, 27]
'@Params["2021", 29, 4, 29]
'@Params["2021", 30, 4, 30]
'@Params["2021", 31, 4, 0]
'@Params["2021", 27, 2, 27]
'@Params["2021", 29, 2, 0]
'@Params["2021", 30, 2, 0]
'@Params["2021", 31, 2, 0]
'@Params["2020", 27, 10, 27]
'@Params["2020", 29, 10, 29]
'@Params["2020", 30, 10, 30]
'@Params["2020", 31, 10, 31]
'@Params["2020", 27, 4, 27]
'@Params["2020", 29, 4, 29]
'@Params["2020", 30, 4, 30]
'@Params["2020", 31, 4, 0]
'@Params["2020", 27, 2, 27]
'@Params["2020", 29, 2, 29]
'@Params["2020", 30, 2, 0]
'@Params["2020", 31, 2, 0]
sub Date_Picker_updateDayContents_adjustsFocusedIndex_whenMonthChanges(yearTitle as string, startDayIndex as integer, endMonthIndex as integer, endDayIndex as integer)
    month = m.datePicker.findNode("month")
    month.setFocus(true)
    month.jumpToItem = 8 ' August has 31 days, start here.
    year = m.datePicker.findNode("year")
    year.setFocus(true)
    for i = 0 to year.content.getChildCount() - 1 step 1
        if year.content.getChild(i).title = yearTitle then
            year.jumpToItem = i
            exit for
        end if
    end for
    if year.itemFocused < 1 then return ' year was not found, skip this test case
    day = m.datePicker.findNode("day")
    day.setFocus(true)
    day.jumpToItem = startDayIndex

    month.setFocus(true)
    month.jumpToItem = endMonthIndex

    day.setFocus(true)

    m.assertEqual(day.itemFocused, endDayIndex)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the isLeapYear function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns the correct value
'@Params[0, false]
'@Params[-120, true]
'@Params[23, false]
'@Params[2000, false]
'@Params[1900, true]
'@Params[2020, true]
'@Params[2024, true]
'@Params[1999, false]
sub Date_Picker_isLeapYear_Returns_ExpectedValue(value as integer, expected as boolean)
    actual = m.datePicker.callFunc("isLeapYear", value)
    m.AssertEqual(expected, actual)
end sub
