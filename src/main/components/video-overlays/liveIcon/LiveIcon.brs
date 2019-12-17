sub init()
    m.logo = m.top.findNode("logo")
    
    ' update logo when fields change
    m.top.observeField("logoUri", "logoChanged")
    m.top.observeField("logoSize", "logoChanged")
    m.top.observeField("logoOpacity", "logoChanged")
    m.top.observeField("position", "logoChanged")
    m.top.observeField("margin", "logoChanged")
    m.top.observeField("fixedPosition", "logoChanged")
    m.top.observeField("logoTranslation", "logoChanged")
    
    ' update video when video changes
    m.top.observeField("videoId", "videoChanged")
end sub

sub logoChanged(event as object)
    if fieldsAreNotSet() = true then return
    if isLiveVideo() = false then return
    videoTranslation = m.video.translation
    videoWidth = m.video.width
    videoHeight = m.video.height
    dim logoPosition[1]
    if m.top.fixedPosition = true and m.top.logoTranslation <> invalid then
        logoPosition[0] = videoTranslation[0] + m.top.logoTranslation[0]
        logoPosition[1] = videoTranslation[1] + m.top.logoTranslation[1]
    else if m.top.position = "topLeft" then
        logoPosition[0] = videoTranslation[0] + m.top.margin
        logoPosition[1] = videoTranslation[1] + m.top.margin
    else if m.top.position = "topRight" then
        logoPosition[0] = videoTranslation[0] + videoWidth - m.top.margin - m.top.logoSize[0]
        logoPosition[1] = videoTranslation[1] + m.top.margin
    else if m.top.position = "bottomLeft" then
        logoPosition[0] = videoTranslation[0] + m.top.margin
        logoPosition[1] = videoTranslation[1] + videoHeight - m.top.margin - m.top.logoSize[1]
    else ' use the default of "bottomRight"
        logoPosition[0] = videoTranslation[0] + videoWidth - m.top.margin - m.top.logoSize[0]
        logoPosition[1] = videoTranslation[1] + videoHeight - m.top.margin - m.top.logoSize[1]
    end if

    m.logo.translation = logoPosition
    m.logo.loadWidth = m.top.logoSize[0]
    m.logo.width = m.top.logoSize[0]
    m.logo.loadHeight = m.top.logoSize[1]
    m.logo.height = m.top.logoSize[1]
    m.logo.uri = m.top.logoUri
end sub

sub videoChanged(event as object)
    videoId = event.getData()
    videoNode = m.top.findNode(videoId)
    parentNode = m.top
    while videoNode = invalid 
        parentNode = parentNode.getParent()
        if parentNode = invalid then return
        videoNode = parentNode.findNode(videoId)
    end while
    if videoNode <> invalid then
        m.video = videoNode
        m.video.observeField("content", "logoChanged")
        logoChanged(invalid)
    end if
end sub

function fieldsAreNotSet() as boolean
    return m.video = invalid or m.top.logoUri = invalid or m.top.margin = invalid or m.top.logoSize = invalid
end function

function isLiveVideo() as boolean
    if m.video.content = invalid then return false
    if m.video.content.live = invalid then return false
    return m.video.content.live
end function