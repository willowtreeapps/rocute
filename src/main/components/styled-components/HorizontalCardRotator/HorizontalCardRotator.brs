sub init()
    ' Scene Generation
    HorizontalCardRotatorList = m.top.findNode("HorizontalCardRotatorList")
    HorizontalCardRotatorList.showTargetRects = false
    HorizontalCardRotatorList.itemComponentName = "HorizontalCardRotatorItem"
    focusedTargetSet = createObject("roSGNode", "TargetSet")
    focusedTargetSet.targetRects = [
        { x: 0, y: 0, width: 200, height: 100 },
        { x: 200, y: 200, width: 200, height: 100 },
        { x: 0, y: 400, width: 200, height: 100 },
    ]
    HorizontalCardRotatorList.targetSet = focusedTargetSet
    HorizontalCardRotatorList.content = createObject("roSGNode", "ContentNode")
    ' Focus Control
    m.HorizontalCardRotatorList = m.top.findNode("HorizontalCardRotatorList")
    m.HorizontalCardRotatorList.setFocus(true)
    m.top.observeField("focusedChild", "handleFocus")
end sub

sub handleFocus(event as object)
    ' Focus Control
    if m.top.isInFocusChain() then
        m.HorizontalCardRotatorList.setFocus(true)
    end if
end sub

sub updateContents()
    ' Sets content
    m.HorizontalCardRotatorList.content = m.top.listContents
end sub

sub updateTargetSet()
    ' Sets size and position
    m.HorizontalCardRotatorList.targetSet = m.top.targetSet
end sub