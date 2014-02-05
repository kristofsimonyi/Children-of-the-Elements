var Alloy = require("alloy"), _ = Alloy._, Backbone = Alloy.Backbone;

Alloy.Globals.rotateLeft = Ti.UI.create2DMatrix().rotate(-90);

Alloy.Globals.rotateRight = Ti.UI.create2DMatrix().rotate(90);

Alloy.Globals.rotateTop = Ti.UI.create2DMatrix().rotate(-180);

Alloy.createController("index");