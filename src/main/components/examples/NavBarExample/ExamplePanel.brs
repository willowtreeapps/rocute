sub init()
    m.top.setFocus(true)
    m.top.vertFocusAnimationStyle = "floatingFocus"
end sub

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