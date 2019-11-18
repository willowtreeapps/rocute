sub init()
    m.list = m.top.findNode("list")
    'm.top.setFocus(true)
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
    m.list.content = content
end sub