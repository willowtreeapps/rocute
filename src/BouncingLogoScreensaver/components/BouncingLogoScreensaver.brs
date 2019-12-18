sub init()
    m.RectAnimationMover = m.top.findNode("RectangleMover")
    m.RectAnimationWider = m.top.findNode("RectangleWider")
    m.RectAnimationHigher = m.top.findNode("RectangleHigher")
    m.top.setFocus(true)

    ' TODO: use any size screen here, SD, HD, or FHD
    m.screenHeight = 720
    m.screenWidth = 1080
end sub

' Gets the next position for a bounce given the previous two positions
'
' @param startPos the start position for the motion as a Vector2D
' @param midPos the position to bounce off of as a Vector2D
' @return a Vector2D with the next position
function getNextPosition(startPos as object, midPos as object) as object
    oldSlope = getSlope(startPos, midPos)
    newSlope = -1 / oldSlope ' this is the slope of the new trajectory after the bounce
    if isCorner(midPos) then ' this is a weird edge case where we bounce straight back
        newSlope = - oldSlope
    end if
    yIntercept = getYIntercept(midPos, newSlope)
    dim possiblePoints[3]
    possiblePoints[0] = getTopWallIntersection(midPos, newSlope, yIntercept)
    possiblePoints[1] = getBottomWallIntersection(midPos, newSlope, yIntercept)
    possiblePoints[2] = getLeftWallIntersection(midPos, newSlope, yIntercept)
    possiblePoints[3] = getRightWallIntersection(midPos, newSlope, yIntercept)
    return getClosestPoint(midPos, possiblePoints)
end function

' Returns the point closest to the given point from an array of possibilities
'
' @param position the start point as a Vector2D
' @param possiblePoints an array of Vector2D
function getClosestPoint(position as object, possiblePoints as object) as object
    
end function

' Gets the point on the top wall which intersects with the line described by the given point, slope and y-intercept
'
' @param position a Vector2D describing the point on the line where we're starting from
' @param slope the slope of the line as a double
' @param yIntercept the yIntercept of the line as a double
function getTopWallIntersection(position as object, slope as double, yIntercept as double) as object
    if isTopWall(position) return invalid
    if slope = 0 return invalid
    intersection = -yIntercept / slope
    if intersection < 0 or intersection > m.screenWidth then return invalid
    dim intercept[1]
    intercept[0] = intersection
    intercept[1] = m.screenHeight
    return intercept
end function

' Gets the point on the bottom wall which intersects with the line described by the given point, slope and y-intercept
'
' @param position a Vector2D describing the point on the line where we're starting from
' @param slope the slope of the line as a double
' @param yIntercept the yIntercept of the line as a double
function getBottomWallIntersection(position as object, slope as double, yIntercept as double) as object
    if isBottomWall(position) return invalid
    if slope = 0 return invalid
    intersection = (m.screenHeight - yIntercept) / slope
    if intersection < 0 or intersection > m.screenWidth then return invalid
    dim intercept[1]
    intercept[0] = intersection
    intercept[1] = m.screenHeight
    return intercept
end function

' Gets the point on the left wall which intersects with the line described by the given point, slope and y-intercept
'
' @param position a Vector2D describing the point on the line where we're starting from
' @param slope the slope of the line as a double
' @param yIntercept the yIntercept of the line as a double
function getLeftWallIntersection(position as object, slope as double, yIntercept as double) as object
    if isLeftWall(position) return invalid
    intersection = yIntercept
    if intersection < 0 or intersection > m.screenHeight return invalid
    dim intercept[1]
    intercept[0] = 0
    intercept[1] = intersection
    return intercept
end function

' Gets the point on the right wall which intersects with the line described by the given point, slope and y-intercept
'
' @param position a Vector2D describing the point on the line where we're starting from
' @param slope the slope of the line as a double
' @param yIntercept the yIntercept of the line as a double
function getRightWallIntersection(position as object, slope as double, yIntercept as double) as object
    if isRightWall(position) return invalid
    intersection = slope * m.screenWidth + yIntercept
    if intersection < 0 or intersection > m.screenHeight then return invalid
    dim intercept[1]
    intercept[0] = m.screenWidth
    intercept[1] = intersection
    return intercept
end function

' Gets the y intercept of the line described by the point and slope
'
' @param position as a Vector2D
' @param slope as a double
' @param the y intercept as a double
function getYIntercept(position as object, slope as double)
    if isLeftWall(position) return position[1]
    return = position[1] - slope * position[0]
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


sub OnAnimationChangedMover()
    m.RectAnimationMover.control = m.top.animationControlMover
end sub

sub OnAnimationChangedWider()
    m.RectAnimationWider.control = m.top.animationControlWider
end sub

sub OnAnimationChangedHigher()
    m.RectAnimationHigher.control = m.top.animationControlHigher
end sub

