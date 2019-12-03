sub init()
    m.contentRotatorRectangle = m.top.findNode("contentRotatorRectangle")
    m.contentRotatorLabel = m.top.findNode("contentRotatorLabel")
end sub

sub itemContentChanged()
    m.contentRotatorLabel.text = m.top.itemContent.title
end sub

sub currRectChanged()
    m.contentRotatorRectangle.width = m.top.currRect.width
    m.contentRotatorRectangle.height = m.top.currRect.height
end sub