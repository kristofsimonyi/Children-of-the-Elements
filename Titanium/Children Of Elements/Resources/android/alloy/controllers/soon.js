function Controller() {
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "soon";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    var __defers = {};
    $.__views.soon = Ti.UI.createWindow({
        id: "soon"
    });
    $.__views.soon && $.addTopLevelView($.__views.soon);
    $.__views.__alloyId1 = Ti.UI.createButton({
        title: "Back",
        id: "__alloyId1"
    });
    $.__views.soon.add($.__views.__alloyId1);
    cerrar ? $.__views.__alloyId1.addEventListener("click", cerrar) : __defers["$.__views.__alloyId1!click!cerrar"] = true;
    exports.destroy = function() {};
    _.extend($, $.__views);
    __defers["$.__views.__alloyId1!click!cerrar"] && $.__views.__alloyId1.addEventListener("click", cerrar);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;