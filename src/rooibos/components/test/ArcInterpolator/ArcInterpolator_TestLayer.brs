function calcAngleWrapper(params as object)
    return calcAngle(params[0], params[1])
end function

function getCircleCoordYWrapper(params as object)
    return getCircleCoordY(params[0], params[1], params[2], params[3], params[4], params[5])
end function

function getCircleCoordXWrapper(params as object)
    return getCircleCoordX(params[0], params[1], params[2], params[3], params[4], params[5])
end function

function getCenter()
    return m.center
end function

function getRadius()
    return m.radius
end function

function getStartAngle()
    return m.startAngle
end function

function getTotalAngle()
    return m.totalAngle
end function

function getNodeToMove()
    return m.nodeToMove
end function