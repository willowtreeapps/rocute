sub init()
  m.pi = 3.1415927
end sub

sub onCoordinateSet()
    ' check that no two points are the same
    if (m.top.start[0] = m.top.middle[0] and m.top.start[1] = m.top.middle[1]) or (m.top.start[0] = m.top.end[0] and m.top.start[1] = m.top.end[1]) or (m.top.middle[0] = m.top.end[0] and m.top.middle[1] = m.top.end[1]) then
        return
    else
        setValues()
    end if
end sub

sub setValues()
    startpoint = m.top.start
    midpoint = m.top.middle
    endpoint = m.top.end
    numOfPoints = m.top.numberOfKeys

    dim center[1]
    center[0] = getCircleCoordX(startpoint[0], startpoint[1], midpoint[0], midpoint[1], endpoint[0], endpoint[1])
    center[1] = getCircleCoordY(startpoint[0], startpoint[1], midpoint[0], midpoint[1], endpoint[0], endpoint[1])
    dim keys[numOfPoints-1]
    dim values[numOfPoints-1]
    keys[0] = 0.0
    keys[numOfPoints-1] = 1.0
    values[0] = startpoint
    values[numOfPoints-1] = endpoint

    radius = sqr(Abs((startpoint[0] - center[0])^2 + (startpoint[1] - center[1])^2))

    startAngle = calcAngle(startpoint, center)
    midAngle = calcAngle(midpoint, center)
    endAngle = calcAngle(endpoint, center)

    bigAngle = true

    totalAngle = endAngle - startAngle
    if (startAngle < midAngle and midAngle < endAngle) or (endAngle < midAngle and midAngle < startAngle) then
        bigAngle = false
    end if
    if bigAngle = true then
        if totalAngle > 0 then
            totalAngle = -(2*m.pi - totalAngle)
        else
            totalAngle = 2*m.pi + totalAngle
        end if
    end if

    for i=1 to numOfPoints-2
        angle = i * (totalAngle/(numOfPoints-1)) + startAngle
        dim position[1]
        position[0] = center[0] + radius * cos(angle)
        position[1] = center[1] + radius * sin(angle)
        keys[i] = i * 1/(numOfPoints-1)
        values[i] = position
    end for
    
    m.top.key = keys
    m.top.keyValue = values
end sub

function calcAngle(edgePoint as object, center as object) as double
    if edgePoint[0] - center[0] = 0 then
        if edgePoint[1] - center[1] > 0 then
            angle = m.pi / 2
        else
            angle = 3*m.pi / 2
        end if
    else
        angle = atn((edgePoint[1]-center[1]) / (edgePoint[0] - center[0]))
        if edgepoint[0] - center[0] < 0 then
            angle = m.pi + angle
        end if
        if angle < 0 then
            angle = (2*m.pi) + angle
        end if
    end if
    return angle
end function

function getCircleCoordY(Ax as Integer, Ay as Integer, Bx as Integer, By as Integer, Cx as Integer, Cy as Integer) as Double
    numerator = (Ay^2)*Bx - (Ay^2)*Cx + (Ax^2)*Bx - (Ax^2)*Cx - (By^2)*Ax - (Bx^2)*Ax + (Cy^2)*Ax + (Cx^2)*Ax + (By^2)*Cx + (Bx^2)*Cx - (Cy^2)*Bx - (Cx^2)*Bx
    denominator = (Ay*Bx - Ay*Cx - Ax*By + Ax*Cy + By*Cx - Bx*Cy) * 2
    return numerator / denominator
end function

function getCircleCoordX(Ax as Integer, Ay as Integer, Bx as Integer, By as Integer, Cx as Integer, Cy as Integer) as Double
    numerator = (Ax^2)*By - (Ay^2)*By - (Ax^2)*Cy + (Ay^2)*Cy + (Bx^2)*Cy - (By^2)*Cy - (Bx^2)*Ay + (By^2)*Ay + (Cx^2)*Ay - (Cy^2)*Ay - (Cx^2)*By + (Cy^2)*By
    denominator = (Ay*Bx - Ay*Cx - Ax*By + Ax*Cy + By*Cx - Bx*Cy) * (-2)
    return numerator / denominator
end function