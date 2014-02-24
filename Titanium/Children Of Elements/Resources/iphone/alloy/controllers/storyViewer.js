function Controller() {
    function init() {
        _story = new Story(currentStoryID);
        _navigator = new Navigator(_story);
        $.storyStage.add(_navigator.init());
    }
    function next() {
        _navigator.next();
    }
    function back() {
        _navigator.back();
    }
    function exitStory() {
        __navigator = null;
        _story = null;
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
        backgroundColor: "#ffffff",
        id: "storyViewer"
    });
    $.__views.storyViewer && $.addTopLevelView($.__views.storyViewer);
    $.__views.storyStage = Ti.UI.createView({
        id: "storyStage"
    });
    $.__views.storyViewer.add($.__views.storyStage);
    $.__views.navBar = Ti.UI.createView({
        height: 100,
        top: 0,
        id: "navBar"
    });
    $.__views.storyViewer.add($.__views.navBar);
    $.__views.back = Ti.UI.createButton({
        backgroundColor: "#182C9F",
        left: 10,
        top: 10,
        title: "Back",
        id: "back"
    });
    $.__views.navBar.add($.__views.back);
    back ? $.__views.back.addEventListener("click", back) : __defers["$.__views.back!click!back"] = true;
    $.__views.home = Ti.UI.createButton({
        backgroundColor: "#182C9F",
        top: 10,
        title: "home",
        id: "home"
    });
    $.__views.navBar.add($.__views.home);
    exitStory ? $.__views.home.addEventListener("click", exitStory) : __defers["$.__views.home!click!exitStory"] = true;
    $.__views.next = Ti.UI.createButton({
        backgroundColor: "#182C9F",
        right: 10,
        top: 10,
        title: "next",
        id: "next"
    });
    $.__views.navBar.add($.__views.next);
    next ? $.__views.next.addEventListener("click", next) : __defers["$.__views.next!click!next"] = true;
    exports.destroy = function() {};
    _.extend($, $.__views);
    var args = arguments[0] || {};
    var currentStoryID = args.storyID;
    var Story = require("/common/StoryBuilder");
    var Navigator = require("/common/StoryNavigator");
    var _story;
    var _navigator;
    $.storyViewer.addEventListener("open", function() {
        init();
    });
    __defers["$.__views.back!click!back"] && $.__views.back.addEventListener("click", back);
    __defers["$.__views.home!click!exitStory"] && $.__views.home.addEventListener("click", exitStory);
    __defers["$.__views.next!click!next"] && $.__views.next.addEventListener("click", next);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;