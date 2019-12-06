sub init()
    m.cardZoomDiagonalRectangle = m.top.findNode("cardZoomDiagonalRectangle")
    m.cardZoomDiagonalLabel = m.top.findNode("cardZoomDiagonalLabel")
    m.cardPoster = m.top.findNode("cardPoster")
end sub

sub itemContentChanged()
    m.cardZoomDiagonalLabel.text = m.top.itemContent.title
    m.cardPoster.uri = m.top.itemContent.SDPosterUrl
    m.cardZoomDiagonalLabel.color = m.top.itemContent.textColor
    m.cardZoomDiagonalRectangle.color = m.top.itemContent.rectColor
    m.cardZoomDiagonalLabel.translation = m.top.itemContent.textCords
end sub

sub currRectChanged()
    m.cardZoomDiagonalRectangle.width = m.top.currRect.width
    m.cardZoomDiagonalRectangle.height = m.top.currRect.height
    m.cardPoster.width = m.top.currRect.width
    m.cardPoster.height = m.top.currRect.height
    m.cardZoomDiagonalLabel.width = m.top.currRect.width
end sub