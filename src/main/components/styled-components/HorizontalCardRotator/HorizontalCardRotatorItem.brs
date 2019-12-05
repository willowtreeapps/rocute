sub init()
    m.horizontalCardRotatorRectangle = m.top.findNode("horizontalCardRotatorRectangle")
    m.horizontalCardRotatorLabel = m.top.findNode("horizontalCardRotatorLabel")
    m.cardPoster = m.top.findNode("cardPoster")
end sub

sub itemContentChanged()
    m.horizontalCardRotatorLabel.text = m.top.itemContent.title
    m.cardPoster.uri = m.top.itemContent.SDPosterUrl
    m.horizontalCardRotatorLabel.color = m.top.itemContent.textColor
    m.horizontalCardRotatorRectangle.color = m.top.itemContent.rectColor
    m.horizontalCardRotatorLabel.translation = m.top.itemContent.textCords
end sub

sub currRectChanged()
    m.horizontalCardRotatorRectangle.width = m.top.currRect.width
    m.horizontalCardRotatorRectangle.height = m.top.currRect.height
    m.cardPoster.width = m.top.currRect.width
    m.cardPoster.height = m.top.currRect.height
    m.horizontalCardRotatorLabel.width = m.top.currRect.width
end sub