sub init()
    m.triangleChopPoster = m.top.findNode("triangleChopPoster")
    m.triangleChopPoster.translation = m.top.translation
end sub

' Sets the file path for the image, and divides logic for either setting up
'   an image now or waiting for an image to be ready for setup
sub setPath ()
    m.triangleChopPoster = m.top.findNode("triangleChopPoster")
    m.triangleChopPoster.uri = m.top.imageUri
    if m.triangleChopPoster.bitmapHeight <> 0 then
        onImageLoad()
    else
        m.triangleChopPoster.observeField("bitmapHeight", "onImageLoad")
    end if
end sub

' When an image is loaded, if the m.top.height field is equal to 0, being default with no bounds set,
'   set the mask up in accordance with the images normal height/width
sub onImageLoad ()
    if m.top.height = 0 then
        m.triangleChopMaskGroup = m.top.findNode("triangleChopMaskGroup")
        m.imgWidth = m.triangleChopPoster.bitmapWidth
        m.imgHeight = m.triangleChopPoster.bitmapHeight
        m.triangleChopMaskGroup.masksize = [m.imgWidth, m.imgHeight]
    end if
    m.triangleChopPoster.unobserveField("bitmapHeight")
end sub

' On m.top.height change set the images height in accordance
sub setHeight()
    m.triangleChopMaskGroup = m.top.findNode("triangleChopMaskGroup")
    if (m.top.width <> 0) ' On the observer function when both height and with are set, set the masksize
        m.triangleChopMaskGroup.masksize = [m.top.width, m.top.height]
    end if
    m.triangleChopPoster = m.top.findNode("triangleChopPoster")
    m.triangleChopPoster.height = m.top.height
end sub

' On m.top.width change set the images width in accordance
sub setWidth()
    m.triangleChopMaskGroup = m.top.findNode("triangleChopMaskGroup")
    if (m.top.height <> 0) ' On the observer function when both height and with are set, set the masksize
        m.triangleChopMaskGroup.masksize = [m.top.width, m.top.height]
    end if
    m.triangleChopPoster = m.top.findNode("triangleChopPoster")
    m.triangleChopPoster.width = m.top.width
end sub

' On m.top.translation change set the images translation in accordance
sub setTranslation()
    m.triangleChopPoster = m.top.findNode("triangleChopPoster")
    m.triangleChopPoster.translation = m.top.translation
end sub