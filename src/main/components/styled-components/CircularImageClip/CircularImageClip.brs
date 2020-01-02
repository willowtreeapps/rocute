sub init()
    m.circleChopPoster = m.top.findNode("circleChopPoster")
    m.circleChopPoster.translation = m.top.translation
end sub

' Sets the file path for the image, and divides logic for either setting up
'   an image now or waiting for an image to be ready for setup
sub setPath ()
    m.circleChopPoster = m.top.findNode("circleChopPoster")
    m.circleChopPoster.uri = m.top.imageUri
    if m.circleChopPoster.bitmapHeight <> 0 then
        onImageLoad()
    else
        m.circleChopPoster.observeField("bitmapHeight", "onImageLoad")
    end if
end sub

' When an image is loaded, if the m.top.height field is equal to 0, being default with no bounds set,
'   set the mask up in accordance with the images normal height/width
sub onImageLoad ()
    if m.top.height = 0 then
        m.circleChopMaskGroup = m.top.findNode("circleChopMaskGroup")
        m.imgWidth = m.circleChopPoster.bitmapWidth
        m.imgHeight = m.circleChopPoster.bitmapHeight
        m.circleChopMaskGroup.masksize = [m.imgWidth, m.imgHeight]
    end if
    m.circleChopPoster.unobserveField("bitmapHeight")
end sub

' On m.top.height change set the images height in accordance
sub setHeight()
    m.circleChopMaskGroup = m.top.findNode("circleChopMaskGroup")
    if (m.top.width <> 0) ' On the observer function when both height and with are set, set the masksize
        m.circleChopMaskGroup.masksize = [m.top.width, m.top.height]
    end if
    m.circleChopPoster = m.top.findNode("circleChopPoster")
    m.circleChopPoster.height = m.top.height
end sub

' On m.top.width change set the images width in accordance
sub setWidth()
    m.circleChopMaskGroup = m.top.findNode("circleChopMaskGroup")
    if (m.top.height <> 0) ' On the observer function when both height and with are set, set the masksize
        m.circleChopMaskGroup.masksize = [m.top.width, m.top.height]
    end if
    m.circleChopPoster = m.top.findNode("circleChopPoster")
    m.circleChopPoster.width = m.top.width
end sub

' On m.top.translation change set the images translation in accordance
sub setTranslation()
    m.circleChopPoster = m.top.findNode("circleChopPoster")
    m.circleChopPoster.translation = m.top.translation
end sub