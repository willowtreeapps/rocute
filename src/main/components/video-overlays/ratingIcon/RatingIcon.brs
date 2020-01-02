sub init()
    m.logo = m.top.findNode("ratingLogo")
    ' set defaults for inner fields
    m.logo.logoOpacity = m.top.logoOpacity
    m.logo.displayTime = m.top.displayTime
    m.logo.fadeTime = m.top.fadeTime
    m.logo.position = m.top.position
    m.logo.margin = m.top.margin
    m.logo.fixedPosition = m.top.fixedPosition
    m.logo.logoTranslation = m.top.logoTranslation
    showParams = createObject("roAssociativeArray")
    showStates = createObject("roArray", 1, true)
    showParams.states = showStates
    m.logo.callFunc("setShowStates", showParams)
end sub

' A method called when the videoId is set
'
' @param event a roSGNodeEvent
sub setVideo(event as object)
    setInnerField(event) ' set the DisappearingLogo field for videoId
    videoId = event.getData()
    m.video = m.top.getParent().findNode(videoId)
    if m.video.content <> invalid and m.video.content.rating <> invalid then
        setRating (m.video.content.rating)
    end if
    m.video.observeField("content", "setContent")
end sub

' A method to set the rating to the given string
'
' @param rating the rating as a string
sub setRating(rating as string)
    if isValidRating(rating) then
        imgString = m.top.iconFolderUri + "/" + rating + ".png"
        m.logo.logoUri = imgString
    end if
end sub

' A method called when the video content changes. This automatically sets the rating.
'
' @param event a roSGNodeEvent
sub setContent(event as object)
    content = event.getData()
    if content = invalid then return
    if content.rating <> invalid then setRating(content.rating)
end sub

' A method to set the fields of the wrapped DisappearingLogo
'
' @param event a roSGNodeEvent
sub setInnerField(event as object)
    m.logo[event.getField()] = event.getData()
end sub

' A function to check for the valid ratings
'
' @param rating the rating as a string
' @return a boolean indicating if it is a valid rating
function isValidRating(rating as string) as boolean
    return rating = "G" or rating = "NC-17" or rating = "PG" or rating = "PG-13" or rating = "R" or rating = "UR" or rating = "UNRATED" or rating = "NR" or rating = "TV-Y" or rating = "TV-Y7" or rating = "TV-Y7-FV" or rating = "TV-G" or rating = "TV-PG" or rating = "TV-14" or rating = "TV-MA"
end function