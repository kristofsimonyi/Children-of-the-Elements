function Controller() {
    function Controller() {
        require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
        this.__controllerPath = "common/toolbar";
        arguments[0] ? arguments[0]["__parentSymbol"] : null;
        arguments[0] ? arguments[0]["$model"] : null;
        arguments[0] ? arguments[0]["__itemTemplate"] : null;
        var $ = this;
        var exports = {};
        $.__views.toolbar = Ti.UI.createLabel({
            text: "HOLO!!!",
            id: "toolbar"
        });
        $.__views.toolbar && $.addTopLevelView($.__views.toolbar);
        exports.destroy = function() {};
        _.extend($, $.__views);
        _.extend($, exports);
    }
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "common/toolbar";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    $.__views.toolbar = Ti.UI.createLabel({
        text: "HOLO!!!",
        id: "toolbar"
    });
    $.__views.toolbar && $.addTopLevelView($.__views.toolbar);
    exports.destroy = function() {};
    _.extend($, $.__views);
    var Alloy = require("alloy"), _ = (Alloy.Backbone, Alloy._);
    module.exports = Controller;
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;