sub init()
    m.cardZoomRotaryRectangle = m.top.findNode("cardZoomRotaryRectangle")
    m.cardZoomRotaryLabel = m.top.findNode("cardZoomRotaryLabel")
    m.cardPoster = m.top.findNode("cardPoster")
end sub

sub itemContentChanged()
    m.cardZoomRotaryLabel.text = m.top.itemContent.title
    m.cardPoster.uri = m.top.itemContent.SDPosterUrl
    m.cardZoomRotaryLabel.color = m.top.itemContent.textColor
    m.cardZoomRotaryRectangle.color = m.top.itemContent.rectColor
    m.cardZoomRotaryLabel.translation = m.top.itemContent.textCords
end sub

sub currRectChanged()
    m.cardZoomRotaryRectangle.width = m.top.currRect.width
    m.cardZoomRotaryRectangle.height = m.top.currRect.height
    m.cardPoster.width = m.top.currRect.width
    m.cardPoster.height = m.top.currRect.height
    m.cardZoomRotaryLabel.width = m.top.currRect.width
end sub