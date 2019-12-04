sub init()
    m.cardRotatorRectangle = m.top.findNode("cardRotatorRectangle")
    m.cardRotatorLabel = m.top.findNode("cardRotatorLabel")
    m.testPoster = m.top.findNode("testPoster")
end sub

sub itemContentChanged()
    m.cardRotatorLabel.text = m.top.itemContent.title
    m.testPoster.uri = m.top.itemContent.SDPosterUrl
end sub

sub currRectChanged()
    m.cardRotatorRectangle.width = m.top.currRect.width
    m.cardRotatorRectangle.height = m.top.currRect.height
    m.testPoster.width = m.top.currRect.width
    m.testPoster.height = m.top.currRect.height
end sub