sub init()
    m.poster = m.top.findNode("poster")
    m.label = m.top.findNode("label")
    m.top.observeField("itemContent", "itemContentChanged")
end sub

sub itemContentChanged(event as object)
    content = event.getData()
    field = event.getField()
    m.label.text = content.title
    m.poster.uri = content.hdPosterUrl
end sub