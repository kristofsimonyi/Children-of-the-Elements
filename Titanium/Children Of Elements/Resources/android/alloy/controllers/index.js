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
    function onSelectPlanet(e) {
        if (!_flagPlanetIsMoving) {
            if (true == e.source.activePlanet) {
                openBookshelf(e.source);
                e.source.activePlanet = false;
            } else {
                _flagPlanetIsMoving = true;
                hidePlanets(e);
            }
            e.source.activePlanet = !e.source.activePlanet;
        }
    }
    function hidePlanets(e) {
        positionMainPlanet(e.source);
        var selectedElement = e.source.id.toString();
        if ($.index.children) for (var c = 0; $.index.children.length > c; c++) {
            var currentItem = $.index.children[c];
            var itemID = currentItem.id.toString();
            itemID != selectedElement && positionSecondaryPlanet(currentItem);
        }
    }
    function positionSecondaryPlanet(_target) {
        var currentItem = _target;
        _target.activePlanet = false;
        currentItem.id.toString();
        var matrix = Ti.UI.create2DMatrix();
        matrix = matrix.rotate(currentItem.preferedRotationBase);
        matrix = matrix.scale(1, 1);
        var planetAnimation = Ti.UI.createAnimation({
            transform: matrix,
            curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
            duration: 600
        });
        _target.preferedTopPosition && (planetAnimation.top = _target.preferedTopPosition.toString());
        _target.preferedLeftPosition && (planetAnimation.left = _target.preferedLeftPosition.toString());
        currentItem.animate(planetAnimation);
    }
    function positionMainPlanet(_target) {
        function animationHandler() {
            _flagPlanetIsMoving = false;
            _target.activePlanet = true;
        }
        var matrix = Ti.UI.create2DMatrix();
        matrix = matrix.rotate(0);
        matrix = matrix.scale(2, 2);
        var animation = Titanium.UI.createAnimation({
            top: "30%",
            left: "40%",
            transform: matrix,
            curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
            duration: 1e3
        });
        _target.animate(animation);
        animation.addEventListener("complete", animationHandler);
    }
    function alignPlanets() {
        $.north.top = -(1 * ($.north.height / 3));
        $.south.top = Titanium.Platform.displayCaps.platformHeight - 2 * ($.south.height / 3);
        $.east.left = -(1 * ($.east.width / 3));
        $.west.left = Titanium.Platform.displayCaps.platformWidth - 2 * ($.west.width / 3);
        $.north.preferedTopPosition = -(2 * ($.north.height / 3));
        $.south.preferedTopPosition = Titanium.Platform.displayCaps.platformHeight - $.south.height / 3;
        $.east.preferedLeftPosition = -(2 * ($.east.width / 3));
        $.west.preferedLeftPosition = Titanium.Platform.displayCaps.platformWidth - $.west.width / 3;
    }
    function openBookshelf(_target) {
        function animationHandler() {
            bookshelfx.open({
                fullscreen: true,
                navBarHidden: true,
                activityEnterAnimation: Ti.Android.R.anim.fade_in,
                activityExitAnimation: Ti.Android.R.anim.fade_out
            });
            $.index.addEventListener("focus", function() {
                cleanUp("show", _target);
            });
        }
        currentID = _target.id.toString();
        Titanium.Platform.displayCaps.platformWidth - 100;
        var matrix = Ti.UI.create2DMatrix();
        matrix = matrix.rotate(-45);
        matrix = matrix.scale(3, 3);
        var animationFinal = Titanium.UI.createAnimation({
            top: "80%",
            left: "10",
            transform: matrix,
            curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
            duration: 1e3
        });
        _target.animate(animationFinal);
        cleanUp("hide", _target);
        var bookshelfx = Alloy.createController("bookshelf", {
            currentItem: _target
        }).getView();
        animationFinal.addEventListener("complete", animationHandler);
    }
    function cleanUp(_action, _target) {
        var clipsVisible = "show" == _action ? 1 : 0;
        if ($.index.children) for (var c = 0; $.index.children.length > c; c++) {
            var currentItem = $.index.children[c];
            if (true != currentItem.activePlanet) {
                var animation = Titanium.UI.createAnimation({
                    opacity: clipsVisible,
                    curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
                    duration: 1e3
                });
                currentItem.animate(animation);
            }
        }
        "show" == _action && positionMainPlanet(_target);
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
        layout: "center",
        id: "index"
    });
    $.__views.index && $.addTopLevelView($.__views.index);
    playLoopAudio ? $.__views.index.addEventListener("open", playLoopAudio) : __defers["$.__views.index!open!playLoopAudio"] = true;
    stopLoopAudio ? $.__views.index.addEventListener("close", stopLoopAudio) : __defers["$.__views.index!close!stopLoopAudio"] = true;
    $.__views.north = Ti.UI.createView({
        width: 250,
        height: 250,
        backgroundImage: "/home/home_planet_north.png",
        transform: Alloy.Globals.rotateTop,
        id: "north",
        preferedRotationBase: "-180"
    });
    $.__views.index.add($.__views.north);
    onSelectPlanet ? $.__views.north.addEventListener("click", onSelectPlanet) : __defers["$.__views.north!click!onSelectPlanet"] = true;
    $.__views.east = Ti.UI.createView({
        width: 250,
        height: 250,
        backgroundImage: "/home/home_planet_east.png",
        transform: Alloy.Globals.rotateRight,
        id: "east",
        preferedRotationBase: "90"
    });
    $.__views.index.add($.__views.east);
    onSelectPlanet ? $.__views.east.addEventListener("click", onSelectPlanet) : __defers["$.__views.east!click!onSelectPlanet"] = true;
    $.__views.west = Ti.UI.createView({
        width: 250,
        height: 250,
        backgroundImage: "/home/home_planet_west.png",
        transform: Alloy.Globals.rotateLeft,
        id: "west",
        preferedRotationBase: "-90"
    });
    $.__views.index.add($.__views.west);
    onSelectPlanet ? $.__views.west.addEventListener("click", onSelectPlanet) : __defers["$.__views.west!click!onSelectPlanet"] = true;
    $.__views.south = Ti.UI.createView({
        width: 250,
        height: 250,
        backgroundImage: "/home/home_planet_south.png",
        id: "south",
        preferedRotationBase: "0"
    });
    $.__views.index.add($.__views.south);
    onSelectPlanet ? $.__views.south.addEventListener("click", onSelectPlanet) : __defers["$.__views.south!click!onSelectPlanet"] = true;
    exports.destroy = function() {};
    _.extend($, $.__views);
    var player;
    var _flagPlanetIsMoving;
    alignPlanets();
    $.index.open({
        fullscreen: true,
        navBarHidden: true,
        exitOnClose: true
    });
    __defers["$.__views.index!open!playLoopAudio"] && $.__views.index.addEventListener("open", playLoopAudio);
    __defers["$.__views.index!close!stopLoopAudio"] && $.__views.index.addEventListener("close", stopLoopAudio);
    __defers["$.__views.north!click!onSelectPlanet"] && $.__views.north.addEventListener("click", onSelectPlanet);
    __defers["$.__views.east!click!onSelectPlanet"] && $.__views.east.addEventListener("click", onSelectPlanet);
    __defers["$.__views.west!click!onSelectPlanet"] && $.__views.west.addEventListener("click", onSelectPlanet);
    __defers["$.__views.south!click!onSelectPlanet"] && $.__views.south.addEventListener("click", onSelectPlanet);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;