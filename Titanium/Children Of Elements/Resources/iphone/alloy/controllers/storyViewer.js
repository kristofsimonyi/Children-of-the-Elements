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
    $.__views.back = Ti.UI.createView({
        left: 0,
        top: 0,
        width: 107,
        height: 99,
        backgroundImage: "/menu/button_prev.png",
        id: "back"
    });
    $.__views.navBar.add($.__views.back);
    back ? $.__views.back.addEventListener("click", back) : __defers["$.__views.back!click!back"] = true;
    $.__views.speech = Ti.UI.createView({
        left: 186,
        top: 0,
        width: 108,
        height: 95,
        backgroundImage: "/menu/button_speech.png",
        id: "speech"
    });
    $.__views.navBar.add($.__views.speech);
    back ? $.__views.speech.addEventListener("click", back) : __defers["$.__views.speech!click!back"] = true;
    $.__views.audio = Ti.UI.createView({
        left: 294,
        top: 0,
        width: 97,
        height: 97,
        backgroundImage: "/menu/button_sound.png",
        id: "audio"
    });
    $.__views.navBar.add($.__views.audio);
    back ? $.__views.audio.addEventListener("click", back) : __defers["$.__views.audio!click!back"] = true;
    $.__views.home = Ti.UI.createView({
        top: 0,
        width: 98,
        height: 93,
        backgroundImage: "/menu/bookshelf_navigator_home.png",
        id: "home"
    });
    $.__views.navBar.add($.__views.home);
    exitStory ? $.__views.home.addEventListener("click", exitStory) : __defers["$.__views.home!click!exitStory"] = true;
    $.__views.next = Ti.UI.createView({
        right: 0,
        top: 0,
        width: 110,
        height: 100,
        backgroundImage: "/menu/button_next.png",
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
    __defers["$.__views.speech!click!back"] && $.__views.speech.addEventListener("click", back);
    __defers["$.__views.audio!click!back"] && $.__views.audio.addEventListener("click", back);
    __defers["$.__views.home!click!exitStory"] && $.__views.home.addEventListener("click", exitStory);
    __defers["$.__views.next!click!next"] && $.__views.next.addEventListener("click", next);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;