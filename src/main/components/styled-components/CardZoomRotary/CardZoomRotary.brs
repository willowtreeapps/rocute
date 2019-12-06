sub init()
    ' Scene Generation
    CardZoomRotaryList = m.top.findNode("CardZoomRotaryList")
    CardZoomRotaryList.showTargetRects = false
    CardZoomRotaryList.itemComponentName = "CardZoomRotaryItem"
    focusedTargetSet = createObject("roSGNode", "TargetSet")
    focusedTargetSet.targetRects = [
        { x: 0, y: 0, width: 200, height: 100 },
        { x: 200, y: 200, width: 200, height: 100 },
        { x: 0, y: 400, width: 200, height: 100 },
    ]
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