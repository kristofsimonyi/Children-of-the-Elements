function Controller() {
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "bookshelf";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    $.__views.bookshelf = Ti.UI.createWindow({
        backgroundColor: "#ffffff",
        layout: "center",
        id: "bookshelf"
    });
    $.__views.bookshelf && $.addTopLevelView($.__views.bookshelf);
    $.__views.inicio = Ti.UI.createLabel({
        id: "inicio"
    });
    $.__views.bookshelf.add($.__views.inicio);
    exports.destroy = function() {};
    _.extend($, $.__views);
    var args = arguments[0] || {};
    $.inicio.text = args.currentItem;
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;