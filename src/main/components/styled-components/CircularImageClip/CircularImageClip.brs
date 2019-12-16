sub init()
end sub

sub setPath ()
    m.circlChopPoster = m.top.findNode("circlChopPoster")
    m.circlChopPoster.uri = m.top.imageUri
    if m.circlChopPoster.bitmapHeight <> 0 then
        onImageLoad()
    else
        m.circlChopPoster.observeField("bitmapHeight", "onImageLoad")
    end if
end sub

sub onImageLoad ()
    if m.top.height = 0 then
        m.circlChopMaskGroup = m.top.findNode("circlChopMaskGroup")
        m.imgWidth = m.circlChopPoster.bitmapWidth
        m.imgHeight = m.circlChopPoster.bitmapHeight
        m.circlChopMaskGroup.masksize = [m.imgWidth, m.imgHeight]
    end if
end sub

sub setHeight()
    m.circlChopMaskGroup = m.top.findNode("circlChopMaskGroup")
    if (m.top.width <> 0)
        m.circlChopMaskGroup.masksize = [m.top.width, m.top.height]
    end if
    m.circlChopPoster = m.top.findNode("circlChopPoster")
    m.circlChopPoster.height = m.top.height
end sub

sub setWidth()
    m.circlChopMaskGroup = m.top.findNode("circlChopMaskGroup")
    if (m.top.height <> 0)
        m.circlChopMaskGroup.masksize = [m.top.width, m.top.height]
    end if
    m.circlChopPoster = m.top.findNode("circlChopPoster")
    m.circlChopPoster.width = m.top.width
end sub