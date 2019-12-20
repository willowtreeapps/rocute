sub init()
end sub

' when the image is passed, which is the one field that is required, everything is kicked off
sub imageUriSet()
    m.ItemMover = m.top.findNode("ItemMover")
    m.BouncingItem = m.top.findNode("BouncingItem")
    m.BouncingItem.uri = m.top.imageUri
    setAnimation()
    durationSet()
    repeatSet()
    m.ItemMover.control = "start"
    m.top.setFocus(true)
end sub

' called for descending bounce animation
sub setAnimation()
    ' initial variable declarations
    totalBounces = m.top.totalBounces
    startPoint = m.top.startPoint
    maxHeight = m.top.maxHeight
    keyArray = []
    keyValueArray = []
    startHeight = startPoint[1]
    constWidth = startPoint[0]
    ' set up number modifyers
    currentTime = 0
    jumpHeight = startHeight - maxHeight ' an int that is going to be chopped down for each decriment
    ' how much each decriment will be
    difHeight = 0
    if m.top.bounceType = "ascending"
        difHeight = -1 * maxHeight / totalBounces
    else if m.top.bounceType = "descending"
        difHeight = maxHeight / totalBounces
    end if
    totalDistance = 0
    for i = 0 to totalBounces
        totalDistance = totalDistance + (maxHeight - (difHeight * i)) * 2
    end for
    'add first value to key/val arrays
    keyArray.push(currentTime)
    keyValueArray.push([constWidth, startHeight])
    ' dynamically populate key/val arrays
    for x = 1 to totalBounces
        ' generate time array for given pass
        bounceTime = (startHeight - jumpHeight) / totalDistance
        currentTime = currentTime + bounceTime
        keyArray.push(currentTime)
        currentTime = currentTime + bouncetime
        keyArray.push(currentTime)
        ' generage position array for given pass
        keyValueArray.push([constWidth, jumpHeight])
        keyValueArray.push([constWidth, startHeight])
        jumpHeight = jumpHeight + difHeight
    end for
    ' set key and keyval arrays
    m.ItemInterp = m.top.findNode("ItemInterp")
    m.ItemInterp.key = keyArray
    m.ItemInterp.keyValue = keyValueArray
end sub

' Calls when duration changes from interface
sub durationSet()
    m.ItemMover = m.top.findNode("ItemMover")
    m.ItemMover.duration = m.top.duration
end sub

' Calls when repeat changes from interface
sub repeatSet()
    m.ItemMover = m.top.findNode("ItemMover")
    m.ItemMover.repeat = m.top.repeat
end sub