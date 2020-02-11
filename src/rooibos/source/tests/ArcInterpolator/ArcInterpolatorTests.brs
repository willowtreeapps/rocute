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
'@It tests the onCoordinateSet and setValues functions
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test call setValues only when all three fields are set, and in any order
'@Params["start", "middle", "end"]
'@Params["start", "end", "middle"]
'@Params["middle", "start", "end"]
'@Params["middle", "end", "start"]
'@Params["end", "start", "middle"]
'@Params["end", "middle", "start"]
sub ArcInterpolator_onCoordinateSet_WorksInAnyOrder(firstField as string, secondField as string, thirdField as string)
    m.arcInterpol.start = invalid
    m.arcInterpol.middle = invalid
    m.arcInterpol.end = invalid
    ' check that setting the fields to invalid didn't call setValues
    m.AssertInvalid(m.arcInterpol.callFunc("getRadius"))

    m.arcInterpol[firstField] = [0,0]
    m.AssertInvalid(m.arcInterpol.callFunc("getRadius"))
    m.arcInterpol[secondField] = [2, 2]
    m.AssertInvalid(m.arcInterpol.callFunc("getRadius"))
    m.arcInterpol[thirdField] = [0, 4]
    m.AssertNotInvalid(m.arcInterpol.callFunc("getRadius"))
end sub

'@Test set expected value on m.center
'@Params[[0, 0], [1, 0], [0, 1], [-1, 0]]
'@Params[[1, 1], [1, -1], [3, 1], [-1, 1]]
sub ArcInterpolator_setValues_SetsExpectedCenterOnM(expected as object, startPoint as object, midPoint as object, endPoint as object)
    m.arcInterpol.start = startPoint
    m.arcInterpol.middle = midPoint
    m.arcInterpol.end = endPoint
    actual = m.arcInterpol.callFunc("getCenter")
    dim diff[1]
    ' check that they are equal to 6 decimal points
    diff[0] = abs(expected[0] - actual[0])
    m.AssertTrue(diff[0] < 0.000001)
    diff[1] = abs(expected[1] - actual[1])
    m.AssertTrue(diff[1] < 0.000001)
end sub

'@Test set expected value on m.radius
'@Params[1, [1, 0], [0, 1], [-1, 0]]
'@Params[2, [1, -1], [3, 1], [-1, 1]]
sub ArcInterpolator_setValues_SetsExpectedRadiusOnM(expected as double, startPoint as object, midPoint as object, endPoint as object)
    m.arcInterpol.start = startPoint
    m.arcInterpol.middle = midPoint
    m.arcInterpol.end = endPoint
    actual = m.arcInterpol.callFunc("getRadius")
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub

'@Test set expected value on m.startAngle
'@Params[0, [1, 0], [0, 1], [-1, 0]]
'@Params[4.71238905, [1, -1], [3, 1], [-1, 1]]
sub ArcInterpolator_setValues_SetsExpectedStartAngleOnM(expected as double, startPoint as object, midPoint as object, endPoint as object)
    m.arcInterpol.start = startPoint
    m.arcInterpol.middle = midPoint
    m.arcInterpol.end = endPoint
    actual = m.arcInterpol.callFunc("getStartAngle")
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub

'@Test set expected value on m.totalAngle
'@Params[3.1415927, [1, 0], [0, 1], [-1, 0]]
'@Params[4.71238905, [1, -1], [3, 1], [-1, 1]]
sub ArcInterpolator_setValues_SetsExpectedTotalAngleOnM(expected as double, startPoint as object, midPoint as object, endPoint as object)
    m.arcInterpol.start = startPoint
    m.arcInterpol.middle = midPoint
    m.arcInterpol.end = endPoint
    actual = m.arcInterpol.callFunc("getTotalAngle")
    ' check that they are equal to 6 decimal points
    diff = abs(expected - actual)
    m.AssertTrue(diff < 0.000001)
end sub

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests the findNodeToMove function
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test sets expected value on m.nodeToMove when nodeToMove is a direct ancestor
'@Params[1]
'@Params[2]
'@Params[5]
sub ArcInterpolator_findNodeToMove_SetsNodeToMoveOnM_GivenNodeIsADirectAncestor(generationCount as integer)
    ' Add the arcInterpol to the testsScene, with a bunch of parents and grandparents.
    parent = m.global.testsScene
    for i = 0 to generationCount - 1
        parent = parent.createChild("Group")
        parent.id = "Group" + stri(i)
    end for
    expected = m.global.testsScene.findNode("Group 0")
    m.AssertNotInvalid(expected)

    animation = parent.createChild("Animation")
    animation.appendChild(m.arcInterpol)

    m.arcInterpol.fieldToInterp="Group 0.translation"
    actual = m.arcInterpol.callFunc("getNodeToMove")
    m.AssertNotInvalid(actual)
    m.AssertEqual(expected, actual)
end sub

'@Test sets expected value on m.nodeToMove when nodeToMove is a direct ancestor
'@IgnoreParams[0]
'@Params[2]
'@Params[5]
sub ArcInterpolator_findNodeToMove_SetsNodeToMoveOnM_GivenNodeIsNotADirectAncestor(generationCount as integer)
    ' Add the arcInterpol to the testsScene, with a bunch of parents and grandparents.
    parent = m.global.testsScene
    for i = 0 to generationCount - 1
        parent = parent.createChild("Group")
    end for
    chosen = parent.createChild("Group")
    chosen.id = "TheChosenOne"
    expected = m.global.testsScene.findNode("TheChosenOne")
    m.AssertNotInvalid(expected)

    animation = parent.createChild("Animation")
    animation.appendChild(m.arcInterpol)

    m.arcInterpol.fieldToInterp="TheChosenOne.translation"
    actual = m.arcInterpol.callFunc("getNodeToMove")
    m.AssertNotInvalid(actual)
    m.AssertEqual(expected, actual)
end sub