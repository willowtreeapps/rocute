function calcAngleWrapper(params as object) as double
    return calcAngle(params[0], params[1])
end function

function getCircleCoordYWrapper(params as object) as double
    return getCircleCoordY(params[0], params[1], params[2], params[3], params[4], params[5])
end function

function getCircleCoordXWrapper(params as object) as double
    return getCircleCoordX(params[0], params[1], params[2], params[3], params[4], params[5])
end function

function getCenter() as object
    return m.center
end function

function getRadius() as double
    return m.radius
end function

function getStartAngle() as double
    return m.startAngle
end function

function getTotalAngle() as double
    return m.totalAngle
end function