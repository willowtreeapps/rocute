sub init()
    m.cardRotatorRectangle = m.top.findNode("cardRotatorRectangle")
    m.cardRotatorLabel = m.top.findNode("cardRotatorLabel")
    ? m.top
end sub

sub itemContentChanged()
    ? m.top
    m.cardRotatorLabel.text = m.top.itemContent.title
end sub

sub currRectChanged()
    m.cardRotatorRectangle.width = m.top.currRect.width
    m.cardRotatorRectangle.height = m.top.currRect.height
end sub