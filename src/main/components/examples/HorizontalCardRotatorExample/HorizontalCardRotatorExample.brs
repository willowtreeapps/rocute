sub init()
    ' Initial Setup & Focus Control
    m.HorizontalCardRotatorExample = m.top.findNode("HorizontalCardRotatorExample")
    m.HorizontalCardRotatorExample.setFocus(true)
    m.top.observeField("focusedChild", "handleFocus")
    ' Content Generation
    generatedContent = createObject("roSGNode", "ContentNode")
    child1 = generatedContent.createChild("ContentNode")
    child1.title = "Intro to Angular"
    child1.SDPosterUrl = "pkg:/images/js-for-test/angular.jpg"
    child1.addField("textColor", "string", false)
    child1.textColor = "#ffffffff"
    child1.addField("rectColor", "string", false)
    child1.rectColor = "#ffffffff"
    child1.addField("textCords", "string", false)
    child1.textCords = "[5,5]"
    child2 = generatedContent.createChild("ContentNode")
    child2.title = "Intro to Ember"
    child2.SDPosterUrl = "pkg:/images/js-for-test/ember.png"
    child2.addField("textColor", "string", false)
    child2.textColor = "#ff0000ff"
    child2.addField("rectColor", "string", false)
    child2.rectColor = "#000000ff"
    child2.addField("textCords", "string", false)
    child2.textCords = "[5,5]"
    child3 = generatedContent.createChild("ContentNode")
    child3.title = "Intro to Polymer"
    child3.SDPosterUrl = "pkg:/images/js-for-test/polymer.png"
    child3.addField("textColor", "string", false)
    child3.textColor = "#00000ff"
    child3.addField("rectColor", "string", false)
    child3.rectColor = "#ffffffff"
    child3.addField("textCords", "string", false)
    child3.textCords = "[5,5]"
    child4 = generatedContent.createChild("ContentNode")
    child4.title = "Intro to React"
    child4.SDPosterUrl = "pkg:/images/js-for-test/react.png"
    child4.addField("textColor", "string", false)
    child4.textColor = "#0000ffff"
    child4.addField("rectColor", "string", false)
    child4.rectColor = "#000000ff"
    child4.addField("textCords", "string", false)
    child4.textCords = "[5,5]"
    child5 = generatedContent.createChild("ContentNode")
    child5.title = "Intro to Vue"
    child5.SDPosterUrl = "pkg:/images/js-for-test/vue.jpeg"
    child5.addField("textColor", "string", false)
    child5.textColor = "#ffffffff"
    child5.addField("rectColor", "string", false)
    child5.rectColor = "#ffffffff"
    child5.addField("textCords", "string", false)
    child5.textCords = "[5,5]"
    ' TargetSet Size Setup
    focusedTargetSet = createObject("roSGNode", "TargetSet")
    focusedTargetSet.targetRects = [
        { x: 0, y: 0, width: 150, height: 75 },
        { x: 50, y: 150, width: 600, height: 300 },
        { x: 500, y: 0, width: 200, height: 100 },
    ]
    ' Assign Content and TargetSet
    m.HorizontalCardRotatorExample.listContents = generatedContent
    m.HorizontalCardRotatorExample.targetSet = focusedTargetSet
    m.top.HorizontalCardRotatorExample = m.HorizontalCardRotatorExample
end sub

sub handleFocus(event as object)
    ' Focus Control
    if m.top.isInFocusChain() then
        m.HorizontalCardRotatorExample.setFocus(true)
    end if
end sub