function Controller() {
    function init() {
        $.MainTitle.text = args.currentItem.id;
        $.descriptionText.text = "This is a placeholder for the  >" + args.currentItem.id.toUpperCase() + "< planet. There is no layout yet...use your imagination in here :)  ";
        setPlanet();
        $.aboutImage.touchEnabled = false;
        $.aboutImage.zIndex = 20;
        $.bookshelf_slide.touchEnabled = false;
        setTimeout(function() {
            _slideshow = new SlideShow();
            $.bookshelf_slide.add(_slideshow);
        }, 1e3);
        _pedals = new PedalMenu($.MainTitle, $.descriptionText);
        $.pedalMenuElement.add(_pedals);
        Ti.App.addEventListener("onShowNewStory", function(e) {
            $.bookshelf_play.storyID = e.storyID;
        });
        $.bookshelf_play.addEventListener("click", function(e) {
            var storyViewer = Alloy.createController("storyViewer", {
                storyID: e.source.storyID
            }).getView();
            storyViewer.open({
                fullscreen: true,
                navBarHidden: true,
                exitOnClose: true
            });
        });
    }
    function setPlanet() {
        var planetObject = $.planetImage;
        var argsObj = args.currentItem;
        planetObject.backgroundImage = argsObj.backgroundImage;
        planetObject.zIndex = 10;
        planetObject.top = "75%";
    }
    function playLoopAudio() {
        player = Ti.Media.createSound({
            url: "/audio/storyOfTheSea.mp3",
            looping: true
        });
        player.looping = true;
        player.play();
    }
    function stopLoopAudio() {
        Ti.App.fireEvent("stopSlideShow");
        player.stop();
    }
    function suscribe() {
        var animation = Titanium.UI.createAnimation({
            opacity: 1,
            duration: 600
        });
        $.aboutImage.touchEnabled = true;
        $.aboutImage.animate(animation);
        $.aboutImage.addEventListener("click", function() {
            var animationx = Titanium.UI.createAnimation({
                opacity: 0,
                duration: 600
            });
            $.aboutImage.animate(animationx);
            $.aboutImage.touchEnabled = false;
        });
    }
    function cerrar() {
        Ti.App.fireEvent("backPlanet");
        _slideshow = null;
        $.bookshelf.close();
    }
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "bookshelf";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    var __defers = {};
    $.__views.bookshelf = Ti.UI.createWindow({
        backgroundColor: "#ffffff",
        layout: "center",
        id: "bookshelf"
    });
    $.__views.bookshelf && $.addTopLevelView($.__views.bookshelf);
    playLoopAudio ? $.__views.bookshelf.addEventListener("open", playLoopAudio) : __defers["$.__views.bookshelf!open!playLoopAudio"] = true;
    stopLoopAudio ? $.__views.bookshelf.addEventListener("close", stopLoopAudio) : __defers["$.__views.bookshelf!close!stopLoopAudio"] = true;
    $.__views.MainTitle = Ti.UI.createLabel({
        color: "#000000",
        right: 0,
        top: 120,
        width: 431,
        font: {
            fontSize: 44
        },
        text: "Legend of the north",
        id: "MainTitle"
    });
    $.__views.bookshelf.add($.__views.MainTitle);
    $.__views.descriptionText = Ti.UI.createLabel({
        color: "#000000",
        right: 146,
        top: 208,
        width: 284,
        font: {
            fontSize: 13
        },
        text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco",
        id: "descriptionText"
    });
    $.__views.bookshelf.add($.__views.descriptionText);
    $.__views.planetImage = Ti.UI.createView({
        width: 250,
        height: 250,
        transform: Alloy.Globals.rotateInterno,
        left: -50,
        id: "planetImage"
    });
    $.__views.bookshelf.add($.__views.planetImage);
    $.__views.bookshelf_slide = Ti.UI.createView({
        bottom: 0,
        right: 0,
        width: 431,
        height: 426,
        id: "bookshelf_slide"
    });
    $.__views.bookshelf.add($.__views.bookshelf_slide);
    $.__views.pedalMenuElement = Ti.UI.createView({
        left: 0,
        bottom: 0,
        width: "630dip",
        height: "660dip",
        id: "pedalMenuElement"
    });
    $.__views.bookshelf.add($.__views.pedalMenuElement);
    $.__views.pedalItems = Ti.UI.createView({
        id: "pedalItems"
    });
    $.__views.pedalMenuElement.add($.__views.pedalItems);
    $.__views.aboutImage = Ti.UI.createImageView({
        width: "100%",
        height: "100%",
        id: "aboutImage",
        image: "/about/aboutScreen.png",
        opacity: "0"
    });
    $.__views.bookshelf.add($.__views.aboutImage);
    $.__views.bookshelf_toolBar = Ti.UI.createView({
        layout: "horizontal",
        left: "40%",
        height: 102,
        top: 0,
        id: "bookshelf_toolBar"
    });
    $.__views.bookshelf.add($.__views.bookshelf_toolBar);
    $.__views.toolbar_button_home = Ti.UI.createImageView({
        width: 93,
        height: 93,
        id: "toolbar_button_home",
        image: "/bookshelf/bookshelf_navigator_home.png"
    });
    $.__views.bookshelf_toolBar.add($.__views.toolbar_button_home);
    cerrar ? $.__views.toolbar_button_home.addEventListener("click", cerrar) : __defers["$.__views.toolbar_button_home!click!cerrar"] = true;
    $.__views.toolbar_button_mute = Ti.UI.createImageView({
        width: 98,
        height: 97,
        id: "toolbar_button_mute",
        image: "/bookshelf/bookshelf_navigator_sound.png"
    });
    $.__views.bookshelf_toolBar.add($.__views.toolbar_button_mute);
    stopLoopAudio ? $.__views.toolbar_button_mute.addEventListener("click", stopLoopAudio) : __defers["$.__views.toolbar_button_mute!click!stopLoopAudio"] = true;
    $.__views.toolbar_button_suscribe = Ti.UI.createImageView({
        width: 101,
        height: 91,
        id: "toolbar_button_suscribe",
        image: "/bookshelf/bookshelf_navigator_suscribe.png"
    });
    $.__views.bookshelf_toolBar.add($.__views.toolbar_button_suscribe);
    suscribe ? $.__views.toolbar_button_suscribe.addEventListener("click", suscribe) : __defers["$.__views.toolbar_button_suscribe!click!suscribe"] = true;
    $.__views.bookshelf_play = Ti.UI.createImageView({
        top: 208,
        left: "88%",
        width: 92,
        height: 89,
        image: "/bookshelf/bookshelf_buton_play.png",
        id: "bookshelf_play"
    });
    $.__views.bookshelf.add($.__views.bookshelf_play);
    exports.destroy = function() {};
    _.extend($, $.__views);
    var args = arguments[0] || {};
    args.currentItem;
    var SlideShow = require("/common/SlideShow");
    var PedalMenu = require("/common/PedalMenu");
    var _slideshow;
    var _pedals;
    init();
    __defers["$.__views.bookshelf!open!playLoopAudio"] && $.__views.bookshelf.addEventListener("open", playLoopAudio);
    __defers["$.__views.bookshelf!close!stopLoopAudio"] && $.__views.bookshelf.addEventListener("close", stopLoopAudio);
    __defers["$.__views.toolbar_button_home!click!cerrar"] && $.__views.toolbar_button_home.addEventListener("click", cerrar);
    __defers["$.__views.toolbar_button_mute!click!stopLoopAudio"] && $.__views.toolbar_button_mute.addEventListener("click", stopLoopAudio);
    __defers["$.__views.toolbar_button_suscribe!click!suscribe"] && $.__views.toolbar_button_suscribe.addEventListener("click", suscribe);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;