sub init()
end sub

sub setPath ()
    m.circleChopPoster = m.top.findNode("circleChopPoster")
    m.circleChopPoster.uri = m.top.imageUri
    if m.circleChopPoster.bitmapHeight <> 0 then
        onImageLoad()
    else
        m.circleChopPoster.observeField("bitmapHeight", "onImageLoad")
    end if
end sub

sub onImageLoad ()
    if m.top.height = 0 then
        m.circleChopMaskGroup = m.top.findNode("circleChopMaskGroup")
        m.imgWidth = m.circleChopPoster.bitmapWidth
        m.imgHeight = m.circleChopPoster.bitmapHeight
        m.circleChopMaskGroup.masksize = [m.imgWidth, m.imgHeight]
    end if
    m.circleChopPoster.unobserveField("bitmapHeight")
end sub

sub setHeight()
    m.circleChopMaskGroup = m.top.findNode("circleChopMaskGroup")
    if (m.top.width <> 0)
        m.circleChopMaskGroup.masksize = [m.top.width, m.top.height]
    end if
    m.circleChopPoster = m.top.findNode("circleChopPoster")
    m.circleChopPoster.height = m.top.height
end sub

sub setWidth()
    m.circleChopMaskGroup = m.top.findNode("circleChopMaskGroup")
    if (m.top.height <> 0)
        m.circleChopMaskGroup.masksize = [m.top.width, m.top.height]
    end if
    m.circleChopPoster = m.top.findNode("circleChopPoster")
    m.circleChopPoster.width = m.top.width
end sub