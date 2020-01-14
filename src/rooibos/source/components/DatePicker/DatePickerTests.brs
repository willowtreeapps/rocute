'@TestSuite [Date_Picker] Unit Tests

' @BeforeEach
sub Date_Picker_create()
    m.datePicker = createObject("roSGNode", "DatePicker_TestLayer")
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the getOffsetString function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test can instantiate with invalid modelLocator
sub Date_Picker_getOffsetString_Returns_Z()
    dateTime = createObject("roDateTime")
    offset = m.datePicker.callFunc("getOffsetString", dateTime)
    m.AssertEqual("Z", offset)
end sub