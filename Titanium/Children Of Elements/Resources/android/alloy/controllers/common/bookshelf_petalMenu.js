function Controller() {
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "common/bookshelf_petalMenu";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    $.__views.pedalMenuElement = Ti.UI.createView({
        id: "pedalMenuElement"
    });
    $.__views.pedalMenuElement && $.addTopLevelView($.__views.pedalMenuElement);
    $.__views.pedal_circleContainer = Ti.UI.createImageView({
        image: "/bookshelf/bookshelf_pedalMenu_container.png",
        id: "pedal_circleContainer"
    });
    $.__views.pedalMenuElement.add($.__views.pedal_circleContainer);
    exports.destroy = function() {};
    _.extend($, $.__views);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;