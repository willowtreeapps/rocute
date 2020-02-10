function calcAngleWrapper(params as object)
    return calcAngle(params[0], params[1])
end function

function getCircleCoordYWrapper(params as object)
    return getCircleCoordY(params[0], params[1], params[2], params[3], params[4], params[5])
end function

function getCircleCoordXWrapper(params as object)
    return getCircleCoordX(params[0], params[1], params[2], params[3], params[4], params[5])
end function