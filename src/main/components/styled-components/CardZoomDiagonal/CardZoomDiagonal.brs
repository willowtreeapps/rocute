sub init()
    ' Scene Generation
    CardZoomDiagonalList = m.top.findNode("CardZoomDiagonalList")
    CardZoomDiagonalList.showTargetRects = true
    CardZoomDiagonalList.itemComponentName = "CardZoomDiagonalItem"
    focusedTargetSet = createObject("roSGNode", "TargetSet")
    focusedTargetSet.targetRects = [
        { x: 0, y: 0, width: 600, height: 300 },
        { x: 35, y: 35, width: 600, height: 300 },
        { x: 70, y: 70, width: 600, height: 300 },
    ]
    focusedTargetSet.focusIndex = 2
    CardZoomDiagonalList.targetSet = focusedTargetSet
    CardZoomDiagonalList.content = createObject("roSGNode", "ContentNode")
    ' Focus Control
    m.CardZoomDiagonalList = m.top.findNode("CardZoomDiagonalList")
    m.CardZoomDiagonalList.setFocus(true)
    m.top.observeField("focusedChild", "handleFocus")
end sub

sub handleFocus(event as object)
    ' Focus Control
    if m.top.isInFocusChain() then
        m.CardZoomDiagonalList.setFocus(true)
    end if
end sub

sub updateContents()
    ' Sets content
    m.CardZoomDiagonalList.content = m.top.listContents
end sub

sub updateTargetSet()
    ' Sets size and position
    m.CardZoomDiagonalList.targetSet = m.top.targetSet
end sub