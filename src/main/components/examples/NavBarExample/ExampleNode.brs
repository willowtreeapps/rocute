' An initialization method for the ExampleNode component.
sub init()
    m.top.vertFocusAnimationStyle = "floatingFocus"
end sub

' A method to set the content of the example node.
' 
' @param event a roSGNodeEvent
sub changeText(event as object)
    value = event.getData()
    ' put the same text in 5 times
    content = createObject("roSGNode", "ContentNode")
    for i=0 to 4
        innerContent = createObject("roSGNode", "ContentNode")
        innerContent.title = value
        content.appendChild(innerContent)
    end for
    m.top.content = content
end sub