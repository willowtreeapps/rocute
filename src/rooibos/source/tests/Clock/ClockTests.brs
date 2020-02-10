'@TestSuite Clock Unit Tests

'@BeforeEach
sub Clock_create()
    m.clock = createObject("roSGNode", "Clock_TestLayer")
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the getTimeString function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns correct string given 24 hour format
'@Params["2015-01-27T13:21:58", "13:21"]
'@Params["2009-01-01T01:00:00", "01:00"]
sub Clock_getTimeString_given24hFormat_Returns_ExpectedString(testTime as string, expected as string)
    dateTime = createObject("roDateTime")
    dateTime.fromISO8601String(testTime)
    m.clock.dateTime = dateTime.asSeconds()
    m.clock.clockFormat = "24h"
    actual = m.clock.callFunc("getTimeString")
    m.AssertEqual(expected, actual)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the toDoubleDigits function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns the correct value
'@Params[0, "00"]
'@Params[1, "01"]
'@Params[10, "10"]
'@Params[3, "03"]
'@Params[5, "05"]
'@Params[12, "12"]
'@Params[15, "15"]
'@Params[30, "30"]
'@Params[45, "45"]
sub Clock_toDoubleDigits_Returns_TwoDigitString(value as integer, expected as string)
    actual = m.clock.callFunc("toDoubleDigits", value)
    m.AssertEqual(expected, actual)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the toSimpleString function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns the correct value
'@Params[0, "0"]
'@Params[1, "1"]
'@Params[10, "10"]
'@Params[3, "3"]
'@Params[5, "5"]
'@Params[12, "12"]
'@Params[15, "15"]
'@Params[30, "30"]
'@Params[45, "45"]
sub Clock_toSimpleString_Returns_ExpectedValue(value as integer, expected as string)
    actual = m.clock.callFunc("toSimpleString", value)
    m.AssertEqual(expected, actual)
end sub
