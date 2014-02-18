function Controller() {
    function init() {
        _story = new Story(currentStoryID);
        $.storyViewer.add(_story);
    }
    function cerrar() {
        $.storyViewer.close();
    }
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "storyViewer";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    var __defers = {};
    $.__views.storyViewer = Ti.UI.createWindow({
        id: "storyViewer"
    });
    $.__views.storyViewer && $.addTopLevelView($.__views.storyViewer);
    $.__views.storyStage = Ti.UI.createView({
        id: "storyStage"
    });
    $.__views.storyViewer.add($.__views.storyStage);
    $.__views.__alloyId1 = Ti.UI.createButton({
        title: "Back",
        id: "__alloyId1"
    });
    $.__views.storyViewer.add($.__views.__alloyId1);
    cerrar ? $.__views.__alloyId1.addEventListener("click", cerrar) : __defers["$.__views.__alloyId1!click!cerrar"] = true;
    exports.destroy = function() {};
    _.extend($, $.__views);
    var args = arguments[0] || {};
    var currentStoryID = args.storyID;
    var Story = require("/common/StoryBuilder");
    var _story;
    $.storyViewer.addEventListener("open", function() {
        init();
    });
    __defers["$.__views.__alloyId1!click!cerrar"] && $.__views.__alloyId1.addEventListener("click", cerrar);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;