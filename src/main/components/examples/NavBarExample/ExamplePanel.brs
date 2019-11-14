sub init()
    m.label = m.top.findNode("label")
end sub

sub changeText(event as object)
    value = event.getData()
    m.label.text = value
end sub