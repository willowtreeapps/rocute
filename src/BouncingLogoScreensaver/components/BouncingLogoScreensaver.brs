' Initialization method for the BouncingLogoScreensaver component.
sub init()
    m.logo = m.top.findNode("Rectangle")
    m.animation = m.top.findNode("RectangleMover")
    m.interpolator = m.top.findNode("RectangleInterp")
    m.timer = m.top.findNode("animationTimer")

    ' TODO: use any size screen here, SD, HD, or FHD
    m.screenHeight = 720 - m.logo.height
    m.screenWidth = 1080
    m.slope = Rnd(m.screenHeight) / Rnd(m.screenWidth)
    m.speed = Rnd(1080)
    animateToNextPoint()
    m.timer.observeField("fire", "animateToNextPoint")
end sub

' Method which animates the logo from a side wall to another side wall.
sub animateToNextPoint()
    position = m.logo.translation
    nextPoint = getNextPosition(position)
    dim points[1]
    points[0] = position
    points[1] = nextPoint
    m.interpolator.keyValue = points
    distance = getDistance(position, nextPoint)
    time = distance / m.speed
    m.animation.duration = time
    m.timer.duration = time

    m.animation.control = "start"
    m.timer.control = "start"
end sub

' Gets the next position for a bounce given the previous two positions
'
' @param position the position to bounce off of as a Vector2D
' @return a Vector2D with the next position
function getNextPosition(position as object) as object
    oldSlope = m.slope
    if isCorner(position) then ' this is a weird edge case where we bounce straight back
        newSlope = oldSlope
    else
        newSlope = - oldSlope
    end if
    m.slope = newSlope
    yIntercept = getYIntercept(position)
    dim possiblePoints[3]
    possiblePoints[0] = getTopWallIntersection(position, yIntercept)
    possiblePoints[1] = getBottomWallIntersection(position, yIntercept)
    possiblePoints[2] = getLeftWallIntersection(position, yIntercept)
    possiblePoints[3] = getRightWallIntersection(position, yIntercept)
    return getClosestPoint(position, possiblePoints)
end function

' Returns the point closest to the given point from an array of possibilities
'
' @param position the start point as a Vector2D
' @param possiblePoints an array of Vector2D
function getClosestPoint(position as object, possiblePoints as object) as object
    maxDistance = sqr(m.screenWidth^2 + m.screenHeight^2)
    closestPoint = invalid
    for each point in possiblePoints
        if point <> invalid then
            return point
            distance = getDistance(position, point)
            if distance < maxDistance then
                maxDistance = distance
                closestPoint = point
            end if
        end if
    end for
    return closestPoint
end function

function getDistance(pointA as object, pointB as object) as double
    deltaX = pointA[0] - pointB[0]
    deltaY = pointA[1] - pointB[1]
    return sqr(deltaX^2 + deltaY^2)
end function

' Gets the point on the top wall which intersects with the line described by the given point and y-intercept
'
' @param position a Vector2D describing the point on the line where we're starting from
' @param yIntercept the yIntercept of the line as a double
function getTopWallIntersection(position as object, yIntercept as double) as object
    if isTopWall(position) return invalid
    if m.slope = 0 return invalid
    intersection = -yIntercept / m.slope
    if intersection < 0 or intersection > m.screenWidth then return invalid
    dim intercept[1]
    intercept[0] = intersection
    intercept[1] = m.screenHeight
    return intercept
end function

' Gets the point on the bottom wall which intersects with the line described by the given point and y-intercept
'
' @param position a Vector2D describing the point on the line where we're starting from
' @param yIntercept the yIntercept of the line as a double
function getBottomWallIntersection(position as object, yIntercept as double) as object
    if isBottomWall(position) return invalid
    if m.slope = 0 return invalid
    intersection = (m.screenHeight - yIntercept) / m.slope
    if intersection < 0 or intersection > m.screenWidth then return invalid
    dim intercept[1]
    intercept[0] = intersection
    intercept[1] = m.screenHeight
    return intercept
end function

' Gets the point on the left wall which intersects with the line described by the given point and y-intercept
'
' @param position a Vector2D describing the point on the line where we're starting from
' @param yIntercept the yIntercept of the line as a double
function getLeftWallIntersection(position as object, yIntercept as double) as object
    if isLeftWall(position) return invalid
    intersection = yIntercept
    if intersection < 0 or intersection > m.screenHeight return invalid
    dim intercept[1]
    intercept[0] = 0
    intercept[1] = intersection
    return intercept
end function

' Gets the point on the right wall which intersects with the line described by the given point and y-intercept
'
' @param position a Vector2D describing the point on the line where we're starting from
' @param yIntercept the yIntercept of the line as a double
function getRightWallIntersection(position as object, yIntercept as double) as object
    if isRightWall(position) return invalid
    intersection = m.slope * m.screenWidth + yIntercept
    if intersection < 0 or intersection > m.screenHeight then return invalid
    dim intercept[1]
    intercept[0] = m.screenWidth
    intercept[1] = intersection
    return intercept
end function

' Gets the y intercept of the line described by the point and m.slope
'
' @param position as a Vector2D
' @return the y intercept as a double
function getYIntercept(position as object) as double
    if isLeftWall(position) return position[1]
    return position[1] - m.slope * position[0]
end function

' Gets the slope of a line through points A and B
'
' @param pointA as a Vector2D
' @param pointB as a Vector2D
' @return the slope as a double
function getSlope(pointA as object, pointB as object) as double
    deltaY = pointB[1] - pointA[1]
    deltaX = pointB[0] - pointA[0]
    if deltaX = 0 then return 1080 ' this is a vertical line and we're not about that here, instead pretend it's not vertical, but very steep
    return deltaY / deltaX
end function

' This function returns whether the position is a corner of the screen or not
' 
' @param position as a Vector2D
' @return a boolean, true if the position is a corner of the screen
function isCorner(position as object) as boolean
    
    if position[0] = 0 and position[1] = 0 then return true ' top left corner
    if position[0] = 0 and position[1] = m.screenHeight then return true ' bottom left corner
    if position[0] = m.screenWidth and position[1] = 0 then return true ' top right corner
    if position[0] = m.screenWidth and position[1] = m.screenHeight then return true ' bottom right corner
    return false
end function

' This function checks if the given position is at the top of the screen
'
' @param position as a Vector2D
' @return true if the position is at the top of the screen
function isTopWall(position as object) as boolean
    return position[1] = 0
end function

' This function checks if the given position is at the bottom of the screen
'
' @param position as a Vector2D
' @return true if the position is at the bottom of the screen
function isBottomWall(position as object) as boolean
    return position[1] = m.screenHeight
end function

' This function checks if the given position is at the left of the screen
'
' @param position as a Vector2D
' @return true if the position is at the left of the screen
function isLeftWall(position as object) as boolean
    return position[0] = 0
end function

' This function checks if the given position is at the right of the screen
'
' @param position as a Vector2D
' @return true if the position is at the right of the screen
function isRightWall(position as object) as boolean
    return position[0] = m.screenWidth
end function