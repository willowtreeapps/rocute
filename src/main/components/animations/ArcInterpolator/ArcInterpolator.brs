sub init()
  m.pi = 3.1415927
  m.top.observeField("fraction", "calculateValue")
  m.top.observeField("key", "createKeyValueArray")
  m.nodeToMove = m.top.findNode("animateMe")
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

    dim center[1]
    center[0] = getCircleCoordX(startpoint[0], startpoint[1], midpoint[0], midpoint[1], endpoint[0], endpoint[1])
    center[1] = getCircleCoordY(startpoint[0], startpoint[1], midpoint[0], midpoint[1], endpoint[0], endpoint[1])
    m.center = center

    m.radius = sqr(Abs((startpoint[0] - m.center[0])^2 + (startpoint[1] - m.center[1])^2))

    m.startAngle = calcAngle(startpoint, m.center)
    midAngle = calcAngle(midpoint, m.center)
    endAngle = calcAngle(endpoint, m.center)

    bigAngle = true

    m.totalAngle = endAngle - m.startAngle
    if (m.startAngle < midAngle and midAngle < endAngle) or (endAngle < midAngle and midAngle < m.startAngle) then
        bigAngle = false
    end if
    if bigAngle = true then
        if m.totalAngle > 0 then
            m.totalAngle = -(2*m.pi - m.totalAngle)
        else
            m.totalAngle = 2*m.pi + m.totalAngle
        end if
    end if
end sub

sub createKeyValueArray(event as object)
    newKeys = event.getData()
    keyCount = newKeys.count()
    dim values[keyCount-1, 0]
    dim valuesAreSet[keyCount-1]

    if keyCount > 0 then
        for i = 0 to keyCount-1
            values[i] = [i, i]
            valuesAreSet[i] = false
        end for
    end if
    m.top.keyValue = values
    m.valuesAreSet = valuesAreSet
end sub

sub calculateValue(event as object)    
    fraction = event.getData()
    keyIndex = indexOf(m.top.key, fraction)
    if keyIndex < 0 then return
    if m.valuesAreSet[keyIndex] = true then return
    angle = fraction * m.totalAngle + m.startAngle
    dim position[1]
    position[0] = m.center[0] + m.radius * cos(angle)
    position[1] = m.center[1] + m.radius * sin(angle)
    'keys[i] = i * 1/(numOfPoints-1)
    m.top.keyValue[keyIndex] = position
    m.valuesAreSet[keyIndex] = true
    if keyIndex = m.top.key.count()-1 then
        m.top.unobserveField("fraction")
        m.top.isKeyValueSet_RDO = true
    end if
    print keyIndex
    'm.top.nodeToMove.translation = position
end sub

function indexOf(anArray as object, value as object) as integer
    for i = 0 to anArray.count()-1
        if abs(anArray[i] - value) < 0.01 then return i
    end for

    return -1
end function

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