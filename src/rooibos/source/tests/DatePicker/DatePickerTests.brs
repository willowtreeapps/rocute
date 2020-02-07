'@TestSuite [Date_Picker] Unit Tests

'@BeforeEach
sub Date_Picker_create()
    m.datePicker = createObject("roSGNode", "DatePicker_TestLayer")
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the getOffsetString function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns Z
sub Date_Picker_getOffsetString_Returns_Z()
    dateTime = createObject("roDateTime")
    offset = m.datePicker.callFunc("getOffsetString", dateTime)
    m.AssertEqual("Z", offset)
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