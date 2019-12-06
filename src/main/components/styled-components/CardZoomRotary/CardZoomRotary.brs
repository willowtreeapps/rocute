sub init()
    ' Scene Generation
    CardZoomRotaryList = m.top.findNode("CardZoomRotaryList")
    CardZoomRotaryList.showTargetRects = true
    CardZoomRotaryList.itemComponentName = "CardZoomRotaryItem"
    focusedTargetSet = createObject("roSGNode", "TargetSet")
    focusedTargetSet.targetRects = [
        { x: 100, y: 0, width: 400, height: 200 },
        { x: 50, y: 100, width: 500, height: 250 },
        { x: 0, y: 200, width: 600, height: 300 },
    ]
    focusedTargetSet.focusIndex = 2
    CardZoomRotaryList.targetSet = focusedTargetSet
    CardZoomRotaryList.content = createObject("roSGNode", "ContentNode")
    ' Focus Control
    m.CardZoomRotaryList = m.top.findNode("CardZoomRotaryList")
    m.CardZoomRotaryList.setFocus(true)
    m.top.observeField("focusedChild", "handleFocus")
end sub

sub handleFocus(event as object)
    ' Focus Control
    if m.top.isInFocusChain() then
        m.CardZoomRotaryList.setFocus(true)
    end if
end sub

sub updateContents()
    ' Sets content
    m.CardZoomRotaryList.content = m.top.listContents
end sub

sub updateTargetSet()
    ' Sets size and position
    m.CardZoomRotaryList.targetSet = m.top.targetSet
end sub