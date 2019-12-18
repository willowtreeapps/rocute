sub init()
    m.RectAnimationMover = m.top.findNode("RectangleMover")
    m.RectAnimationWider = m.top.findNode("RectangleWider")
    m.RectAnimationHigher = m.top.findNode("RectangleHigher")
    m.top.setFocus(true)
end sub

' Gets the next position for a bounce given the previous two positions
'
' @param startPos the start position for the motion as a Vector2D
' @param midPos the position to bounce off of as a Vector2D
' @return a Vector2D with the next position
function getNextPosition(startPos as object, midPos as object) as object
    
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

