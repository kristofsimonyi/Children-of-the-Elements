function Controller() {
    function init() {
        $.inicio.text = args.currentItem.id;
        setPlanetPosition();
    }
    function setPlanetPosition() {
        $.planetImage.top = args.currentItem.top;
        $.planetImage.left = args.currentItem.left;
        $.planetImage.transform = args.currentItem.transform;
        $.planetImage.width = args.currentItem.width;
        $.planetImage.height = args.currentItem.height;
        $.planetImage.backgroundImage = args.currentItem.backgroundImage;
    }
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
    $.__views.planetImage = Ti.UI.createView({
        id: "planetImage"
    });
    $.__views.bookshelf.add($.__views.planetImage);
    exports.destroy = function() {};
    _.extend($, $.__views);
    var args = arguments[0] || {};
    args.currentItem;
    init();
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;