'@TestSuite ArcInterpolator Unit Tests

'@BeforeEach
sub ArcInterpolator_create()
    m.arcInterpol = createObject("roSGNode", "ArcInterpolator_TestLayer")
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the calcAngle function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns expected result
'@Params[0, [[1, 0], [0,0]]]
'@Params[3.1415927, [[-1,0], [0,0]]]
'@Params[1.57079635, [[0,1], [0,0]]]
'@Params[4.71238905, [[0,-1], [0,0]]]
'@Params[0.785398175, [[1, 1], [0,0]]]
'@Params[2.356194525, [[-1, 1], [0,0]]]
'@Params[3.926990875, [[-1, -1], [0,0]]]
'@Params[5.497787225, [[1, -1], [0,0]]]
sub ArcInterpolator_calcAngle_Returns_ExpectedResult(expected as double, params as object)
    actual = m.arcInterpol.callFunc("calcAngleWrapper", params)
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the getCircleCoordY function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns expected result
'@Params[0, [1, 0, 0, 1, -1, 0]]
sub ArcInterpolator_getCircleCoordY_Returns_ExpectedResult(expected as double, params as object)
    actual = m.arcInterpol.callFunc("getCircleCoordYWrapper", params)
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the getCircleCoordX function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test returns expected result
'@Params[0, [1, 0, 0, 1, -1, 0]]
sub ArcInterpolator_getCircleCoordX_Returns_ExpectedResult(expected as double, params as object)
    actual = m.arcInterpol.callFunc("getCircleCoordXWrapper", params)
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the setValues function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test sets expected value on m.center
'@Params[[0, 0], [1, 0], [0, 1], [-1, 0]]
'@Params[[1, 1], [1, -1], [3, 1], [-1, 1]]
sub ArcInterpolator_setValues_SetsExpectedCenterOnM(expected as object, startPoint as object, midPoint as object, endPoint as object)
    m.arcInterpol.start = startPoint
    m.arcInterpol.middle = midPoint
    m.arcInterpol.end = endPoint
    m.arcInterpol.callFunc("setValues")
    actual = m.arcInterpol.callFunc("getCenter")
    dim diff[1]
    ' check that they are equal to 6 decimal points
    diff[0] = abs(expected[0] - actual[0])
    m.AssertTrue(diff[0] < 0.000001)
    diff[1] = abs(expected[1] - actual[1])
    m.AssertTrue(diff[1] < 0.000001)
end sub

'@Test sets expected value on m.radius
'@Params[1, [1, 0], [0, 1], [-1, 0]]
'@Params[2, [1, -1], [3, 1], [-1, 1]]
sub ArcInterpolator_setValues_SetsExpectedRadiusOnM(expected as double, startPoint as object, midPoint as object, endPoint as object)
    m.arcInterpol.start = startPoint
    m.arcInterpol.middle = midPoint
    m.arcInterpol.end = endPoint
    m.arcInterpol.callFunc("setValues")
    actual = m.arcInterpol.callFunc("getRadius")
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub

'@Test sets expected value on m.startAngle
'@Params[0, [1, 0], [0, 1], [-1, 0]]
'@Params[4.71238905, [1, -1], [3, 1], [-1, 1]]
sub ArcInterpolator_setValues_SetsExpectedStartAngleOnM(expected as double, startPoint as object, midPoint as object, endPoint as object)
    m.arcInterpol.start = startPoint
    m.arcInterpol.middle = midPoint
    m.arcInterpol.end = endPoint
    m.arcInterpol.callFunc("setValues")
    actual = m.arcInterpol.callFunc("getStartAngle")
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub

'@Test sets expected value on m.totalAngle
'@Params[3.1415927, [1, 0], [0, 1], [-1, 0]]
'@Params[4.71238905, [1, -1], [3, 1], [-1, 1]]
sub ArcInterpolator_setValues_SetsExpectedTotalAngleOnM(expected as double, startPoint as object, midPoint as object, endPoint as object)
    m.arcInterpol.start = startPoint
    m.arcInterpol.middle = midPoint
    m.arcInterpol.end = endPoint
    m.arcInterpol.callFunc("setValues")
    actual = m.arcInterpol.callFunc("getTotalAngle")
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub