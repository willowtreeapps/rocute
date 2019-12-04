sub init()
    m.cardRotatorRectangle = m.top.findNode("cardRotatorRectangle")
    m.cardRotatorLabel = m.top.findNode("cardRotatorLabel")
    m.cardPoster = m.top.findNode("cardPoster")
end sub

sub itemContentChanged()
    m.cardRotatorLabel.text = m.top.itemContent.title
    m.cardPoster.uri = m.top.itemContent.SDPosterUrl
    m.cardRotatorLabel.color = m.top.itemContent.textColor
    m.cardRotatorRectangle.color = m.top.itemContent.rectColor
    m.cardRotatorLabel.translation = m.top.itemContent.textCords
end sub

sub currRectChanged()
    m.cardRotatorRectangle.width = m.top.currRect.width
    m.cardRotatorRectangle.height = m.top.currRect.height
    m.cardPoster.width = m.top.currRect.width
    m.cardPoster.height = m.top.currRect.height
    m.cardRotatorLabel.width = m.top.currRect.width
end sub