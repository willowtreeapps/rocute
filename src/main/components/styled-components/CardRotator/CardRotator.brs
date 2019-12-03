sub init()
    ' Scene Generation
    CardRotatorList = m.top.findNode("CardRotatorList")
    CardRotatorList.showTargetRects = false
    CardRotatorList.itemComponentName = "CardRotatorItem"
    focusedTargetSet = createObject("roSGNode", "TargetSet")
    CardRotatorList.targetSet = focusedTargetSet
    CardRotatorList.content = createObject("roSGNode", "ContentNode")
    ' Focus Control
    m.CardRotatorList = m.top.findNode("CardRotatorList")
    m.CardRotatorList.setFocus(true)
    m.top.observeField("focusedChild", "handleFocus")
end sub

sub handleFocus(event as object)
    ' Focus Control
    if m.top.isInFocusChain() then
        m.CardRotatorList.setFocus(true)
    end if
end sub

sub updateContents()
    ' Sets content
    m.CardRotatorList.content = m.top.listContents
end sub

sub updateTargetSet()
    ' Sets size and position
    m.CardRotatorList.targetSet = m.top.targetSet
end sub