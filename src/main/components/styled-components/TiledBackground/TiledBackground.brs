' Initialization method for the TiledBackground component
sub init()
end sub

' When the image is set or changed, this is called to observe the image's width and height before tiling the image.
'
' @param event a roSGNodeEvent
sub onImageSet(event as object)
    m.firstPoster = createObject("roSGNode", "Poster")
    m.firstPoster.uri = m.top.imgUri
    m.top.appendChild(m.firstPoster)
    if areFieldsInitialized() = true then
        onImageLoad(invalid)
    else
        m.top.observeField("width", "onImageLoad")
        m.top.observeField("height", "onImageLoad")
        m.firstPoster.observeField("bitmapWidth", "onImageLoad")
        m.firstPoster.observeField("bitmapHeight", "onImageLoad")
    end if
end sub

' This method is called once the image's width or height is known and it tiles the image.
'
' @param event a roSGNodeEvent
sub onImageLoad(event as object)
    'do nothing if all appropriate fields are not initialized yet
    if areFieldsInitialized() = false then return
    m.imgHeight = m.firstPoster.bitmapHeight
    m.imgWidth = m.firstPoster.bitmapWidth
    m.rectWidth = m.top.width
    m.rectHeight = m.top.height

    for x = 0 to m.rectWidth step m.imgWidth
        for y = 0 to m.rectHeight step m.imgHeight
            bgPoster = createObject("roSGNode", "Poster")
            bgPoster.uri = m.top.imgUri
            bgPoster.translation = [x,y]
            m.top.appendChild(bgPoster)
        end for
    end for
    m.top.removeChild(m.firstPoster)
end sub

' A function to check if the widths and heights of the TiledBackground and the image are all known.
'
' @return true if all fields are greater than 0, false otherwise.
function areFieldsInitialized() as boolean
    return m.firstPoster.bitmapWidth > 0 and m.firstPoster.bitmapHeight > 0 and m.top.width > 0 and m.top.height > 0
end function