sub init()
    m.ContentRotatorExample = m.top.findNode("ContentRotatorExample")
    m.ContentRotatorExample.setFocus(true)
    m.top.observeField("focusedChild", "handleFocus")
end sub

sub handleFocus(event as object)
    if m.top.isInFocusChain() then
        m.ContentRotatorExample.setFocus(true)
    end if
end sub