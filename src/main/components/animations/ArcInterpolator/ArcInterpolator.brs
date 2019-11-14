sub init()
  m.pi = 3.1415927
  m.top.observeField("fraction", "calculateValue")
  m.top.observeField("fieldToInterp", "findNodeToMove")
end sub

sub findNodeToMove(event as object)
    nodeAndField = event.getData()
    if right(nodeAndField, 12) <> ".translation" then return
    length = len(nodeAndField)
    nodeName = left(nodeAndField, length - 12)
    
    currentNode = m.top
    while currentNode.getParent() <> invalid
        currentNode = currentNode.getParent()
        node = currentNode.findNode(nodeName)
        if node <> invalid
            m.nodeToMove = node
            return
        end if
    end while
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

sub calculateValue(event as object)    
    fraction = event.getData()
    angle = fraction * m.totalAngle + m.startAngle
    dim position[1]
    position[0] = m.center[0] + m.radius * cos(angle)
    position[1] = m.center[1] + m.radius * sin(angle)
    m.nodeToMove.translation = position
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