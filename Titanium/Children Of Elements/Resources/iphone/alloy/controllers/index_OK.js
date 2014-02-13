function Controller() {
    function alignPlanets() {
        $.north.top = -($.north.height / 3);
        $.south.bottom = -($.south.height / 3);
        $.east.left = -($.east.width / 3);
        $.west.right = -($.west.width / 3);
        $.north.preferedTopPosition = 2 * -($.north.height / 3);
        $.east.preferedLeftPosition = 2 * -($.east.width / 3);
        $.south.preferedTopPosition = Titanium.Platform.displayCaps.platformHeight - 1 * ($.south.height / 3);
        $.west.preferedLeftPosition = Titanium.Platform.displayCaps.platformWidth - 1 * ($.south.width / 3);
    }
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "index_OK";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    exports.destroy = function() {};
    _.extend($, $.__views);
    alignPlanets();
    $.index.open({
        fullscreen: true,
        navBarHidden: true,
        exitOnClose: false
    });
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;