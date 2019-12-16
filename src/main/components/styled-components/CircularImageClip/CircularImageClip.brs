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
    if m.top.height = 0
        m.circlChopMaskGroup = m.top.findNode("circlChopMaskGroup")
        m.imgWidth = m.circlChopPoster.bitmapWidth
        m.imgHeight = m.circlChopPoster.bitmapHeight
        m.circlChopMaskGroup.masksize = [m.imgWidth, m.imgHeight]
    else
        m.circlChopMaskGroup = m.top.findNode("circlChopMaskGroup")
        m.circlChopMaskGroup.masksize = [m.top.width, m.top.height]
        m.circlChopPoster = m.top.findNode("circlChopPoster")
        m.circlChopPoster.width = m.top.width
        m.circlChopPoster.height = m.top.height
    end if
end sub