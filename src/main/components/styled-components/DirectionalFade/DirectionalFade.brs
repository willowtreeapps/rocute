' Init function
sub init()
    m.directionalFadeMaskGroup = m.top.findNode("directionalFadeMaskGroup")
    m.directionalFadeMaskGroup.maskUri = "pkg:/images/directionalFades/directionalFadeBottom.png"
end sub

' Sets the image path to the provided image.
sub setPath()
    m.directionalFadePoster = m.top.findNode("directionalFadePoster")
    m.directionalFadePoster.uri = m.top.imageUri
end sub

' Sets the mask path to the required image.
sub setMaskPath()
    m.directionalFadeMaskGroup = m.top.findNode("directionalFadeMaskGroup")
    fadedSide = m.top.fadedSide
    if fadedSide = "top"
        m.directionalFadeMaskGroup.maskUri = "pkg:/images/directionalFades/directionalFadeTop.png"
    end if
    if fadedSide = "right"
        m.directionalFadeMaskGroup.maskUri = "pkg:/images/directionalFades/directionalFadeRight.png"
    end if
    if fadedSide = "bottom"
        m.directionalFadeMaskGroup.maskUri = "pkg:/images/directionalFades/directionalFadeBottom.png"
    end if
    if fadedSide = "left"
        m.directionalFadeMaskGroup.maskUri = "pkg:/images/directionalFades/directionalFadeLeft.png"
    end if
    dimensionMake()
end sub

' Function to be called multiple times as variables arive to set the dimensions of the picture and
'       set up the mask. It will run through once when all the required variables arive.
sub dimensionMake()
    offset = m.top.offset
    width = m.top.width
    height = m.top.height
    fadedSide = m.top.fadedSide
    if offset <> 0 and fadedSide <> "" and width <> 0 and height <> 0 then
        m.directionalFadeMaskGroup = m.top.findNode("directionalFadeMaskGroup")
        m.directionalFadePoster = m.top.findNode("directionalFadePoster")
        m.directionalFadePoster.width = width
        m.directionalFadePoster.height = height
        if fadedSide = "left" or fadedSide = "right" then
            m.directionalFadeMaskGroup.maskOffset = [offset, 0]
        end if
        if fadedSide = "top" or fadedSide = "bottom" then
            m.directionalFadeMaskGroup.maskOffset = [0, offset]
        end if
    end if
end sub

' Sets the translation of the image if one is provided.
sub setTranslation()
    m.directionalFadePoster = m.top.findNode("directionalFadePoster")
    m.directionalFadePoster.translation = m.top.translation
end sub