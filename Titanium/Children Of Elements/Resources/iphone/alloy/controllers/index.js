function Controller() {
    function doClick() {
        alert($.label.text);
    }
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "index";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    var __defers = {};
    $.__views.index = Ti.UI.createWindow({
        backgroundImage: "/home/background_home.png",
        id: "index"
    });
    $.__views.index && $.addTopLevelView($.__views.index);
    $.__views.label = Ti.UI.createLabel({
        text: "Hello, World",
        id: "label"
    });
    $.__views.index.add($.__views.label);
    doClick ? $.__views.label.addEventListener("click", doClick) : __defers["$.__views.label!click!doClick"] = true;
    $.__views.north = Ti.UI.createView({
        width: 100,
        height: 100,
        backgroundColor: "#ffffff",
        top: -50,
        id: "north"
    });
    $.__views.index.add($.__views.north);
    $.__views.east = Ti.UI.createView({
        id: "east"
    });
    $.__views.index.add($.__views.east);
    $.__views.west = Ti.UI.createView({
        id: "west"
    });
    $.__views.index.add($.__views.west);
    $.__views.south = Ti.UI.createView({
        width: 100,
        height: 100,
        backgroundColor: "#ffffff",
        bottom: -50,
        id: "south"
    });
    $.__views.index.add($.__views.south);
    exports.destroy = function() {};
    _.extend($, $.__views);
    $.index.open({
        fullscreen: true,
        navBarHidden: true
    });
    __defers["$.__views.label!click!doClick"] && $.__views.label.addEventListener("click", doClick);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;