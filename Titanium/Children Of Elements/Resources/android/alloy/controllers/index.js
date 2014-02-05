function Controller() {
    function playLoopAudio() {
        player = Ti.Media.createSound({
            url: "/audio/loopTest.mp3",
            looping: true
        });
        player.looping = true;
        player.play();
    }
    function stopLoopAudio() {
        player.stop();
    }
    function selectPlanet(e) {
        true == e.source.activePlanet;
        hidePlanets(e);
        e.source.activePlanet = !e.source.activePlanet;
    }
    function hidePlanets(e) {
        e.source.originalHeight = e.source.height;
        e.source.originalWidth = e.source.width;
        e.source.originalTop = e.source.top;
        e.source.originalTransform = e.source.transform;
        e.source.originalBottom = e.source.bottom;
        e.source.originalLeft = e.source.left;
        e.source.originalRight = e.source.right;
        var matrix = Ti.UI.create2DMatrix();
        matrix = matrix.rotate(0);
        matrix = matrix.scale(2, 2);
        var animation = Titanium.UI.createAnimation({
            top: "30%",
            left: "40%",
            transform: matrix,
            curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
            duration: 2e3
        });
        e.source.animate(animation);
        var selectedElement = e.source.id.toString();
        if ($.index.children) for (var c = 0; $.index.children.length > c; c++) {
            var currentItem = $.index.children[c];
            var itemID = currentItem.id.toString();
            var matrix = Ti.UI.create2DMatrix();
            matrix = matrix.rotate(currentItem.preferedRotationBase);
            matrix = matrix.scale(1, 1);
            Ti.API.info(currentItem.preferedRightPosition);
            itemID != selectedElement ? currentItem.animate({
                top: 500,
                left: 500,
                right: currentItem.preferedRightPosition,
                bottom: currentItem.peferedBottomPosition,
                transform: matrix,
                curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
                duration: 1e3
            }) : Ti.API.info($.index.children[c].id + " " + e.source.id);
            currentItem = null;
            matrix = null;
        }
    }
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "index";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    var __defers = {};
    $.__views.index = Ti.UI.createWindow({
        backgroundImage: "/home/background_home.png",
        id: "index"
    });
    $.__views.index && $.addTopLevelView($.__views.index);
    playLoopAudio ? $.__views.index.addEventListener("open", playLoopAudio) : __defers["$.__views.index!open!playLoopAudio"] = true;
    stopLoopAudio ? $.__views.index.addEventListener("close", stopLoopAudio) : __defers["$.__views.index!close!stopLoopAudio"] = true;
    $.__views.north = Ti.UI.createView({
        width: 250,
        height: 250,
        backgroundImage: "/home/home_planet_north.png",
        top: -130,
        transform: Alloy.Globals.rotateTop,
        id: "north",
        preferedRotationBase: "-180",
        preferedTopPosition: "-130",
        preferedRightPosition: "",
        preferedLeftPosition: "",
        peferedBottomPosition: ""
    });
    $.__views.index.add($.__views.north);
    selectPlanet ? $.__views.north.addEventListener("click", selectPlanet) : __defers["$.__views.north!click!selectPlanet"] = true;
    $.__views.east = Ti.UI.createView({
        width: 250,
        height: 250,
        backgroundImage: "/home/home_planet_east.png",
        left: -100,
        transform: Alloy.Globals.rotateRight,
        id: "east",
        preferedRotationBase: "90",
        preferedTopPosition: "",
        preferedRightPosition: "",
        preferedLeftPosition: "-100",
        peferedBottomPosition: ""
    });
    $.__views.index.add($.__views.east);
    selectPlanet ? $.__views.east.addEventListener("click", selectPlanet) : __defers["$.__views.east!click!selectPlanet"] = true;
    $.__views.west = Ti.UI.createView({
        width: 250,
        height: 250,
        backgroundImage: "/home/home_planet_west.png",
        right: -100,
        transform: Alloy.Globals.rotateLeft,
        id: "west",
        preferedRotationBase: "-90",
        preferedTopPosition: "",
        preferedRightPosition: "-100",
        preferedLeftPosition: "",
        peferedBottomPosition: ""
    });
    $.__views.index.add($.__views.west);
    selectPlanet ? $.__views.west.addEventListener("click", selectPlanet) : __defers["$.__views.west!click!selectPlanet"] = true;
    $.__views.south = Ti.UI.createView({
        width: 250,
        height: 250,
        backgroundImage: "/home/home_planet_south.png",
        bottom: -100,
        id: "south",
        preferedRotationBase: "0",
        preferedTopPosition: "",
        preferedRightPosition: "",
        preferedLeftPosition: "",
        peferedBottomPosition: "-100"
    });
    $.__views.index.add($.__views.south);
    selectPlanet ? $.__views.south.addEventListener("click", selectPlanet) : __defers["$.__views.south!click!selectPlanet"] = true;
    exports.destroy = function() {};
    _.extend($, $.__views);
    $.index.open({
        fullscreen: true,
        navBarHidden: true
    });
    var player;
    __defers["$.__views.index!open!playLoopAudio"] && $.__views.index.addEventListener("open", playLoopAudio);
    __defers["$.__views.index!close!stopLoopAudio"] && $.__views.index.addEventListener("close", stopLoopAudio);
    __defers["$.__views.north!click!selectPlanet"] && $.__views.north.addEventListener("click", selectPlanet);
    __defers["$.__views.east!click!selectPlanet"] && $.__views.east.addEventListener("click", selectPlanet);
    __defers["$.__views.west!click!selectPlanet"] && $.__views.west.addEventListener("click", selectPlanet);
    __defers["$.__views.south!click!selectPlanet"] && $.__views.south.addEventListener("click", selectPlanet);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;