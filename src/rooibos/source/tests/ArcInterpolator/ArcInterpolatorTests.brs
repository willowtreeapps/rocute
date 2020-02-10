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
