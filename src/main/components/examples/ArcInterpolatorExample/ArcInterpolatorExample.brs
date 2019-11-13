sub init()
    m.arcInterpolator = m.top.findNode("arcInterpol")
    m.arcAnimator = m.top.findNode("animate")
    m.arcInterpolator.observeField("isKeyValueSet_RDO", "startAnimation")
    'm.arcAnimator.control = "start"
end sub

sub startAnimation()
    m.arcAnimator.control = "start"
end sub