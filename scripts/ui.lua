hjapi.DzLoadToc("UI\\frame.toc")
hjapi.DzEnableWideScreen(true)
hjapi.DzFrameHideInterface()
hjapi.DzFrameEditBlackBorders(0, 0)

UI = function()
    local demo = require("scripts.uiDemo")
    demo.run()
end