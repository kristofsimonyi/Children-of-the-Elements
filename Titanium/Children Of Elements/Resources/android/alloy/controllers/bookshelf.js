function Controller() {
    function init() {
        $.inicio.text = args.currentItem.id;
        $.texto.text = "This is a placeholder for the  >" + args.currentItem.id.toUpperCase() + "< planet. There is no layout yet...use your imagination in here :)  ";
        setPlanet();
    }
    function setPlanet() {
        var object = $.planetImage;
        var argsObj = args.currentItem;
        object.backgroundImage = argsObj.backgroundImage;
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
        player.stop();
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
        backgroundImage: "/home/background_home.png",
        layout: "center",
        id: "bookshelf"
    });
    $.__views.bookshelf && $.addTopLevelView($.__views.bookshelf);
    playLoopAudio ? $.__views.bookshelf.addEventListener("open", playLoopAudio) : __defers["$.__views.bookshelf!open!playLoopAudio"] = true;
    stopLoopAudio ? $.__views.bookshelf.addEventListener("close", stopLoopAudio) : __defers["$.__views.bookshelf!close!stopLoopAudio"] = true;
    $.__views.__alloyId0 = Ti.UI.createView({
        backgroundColor: "#000000",
        opacity: "0.6",
        width: "50%",
        height: "40%",
        top: "15%",
        right: "5%",
        borderRadius: "10",
        id: "__alloyId0"
    });
    $.__views.bookshelf.add($.__views.__alloyId0);
    $.__views.inicio = Ti.UI.createLabel({
        color: "#ffffff",
        text: "Legend of the north",
        id: "inicio",
        top: "18%",
        left: "46%",
        width: "40%"
    });
    $.__views.bookshelf.add($.__views.inicio);
    $.__views.texto = Ti.UI.createLabel({
        color: "#ffffff",
        text: "Lorem Ipsum",
        id: "texto",
        top: "25%",
        left: "46%",
        width: "40%"
    });
    $.__views.bookshelf.add($.__views.texto);
    $.__views.planetImage = Ti.UI.createView({
        top: "80%",
        left: "10",
        width: 250,
        height: 250,
        transform: Alloy.Globals.rotateInterno,
        backgroundImage: "/home/home_planet_north.png",
        id: "planetImage"
    });
    $.__views.bookshelf.add($.__views.planetImage);
    exports.destroy = function() {};
    _.extend($, $.__views);
    var args = arguments[0] || {};
    args.currentItem;
    init();
    __defers["$.__views.bookshelf!open!playLoopAudio"] && $.__views.bookshelf.addEventListener("open", playLoopAudio);
    __defers["$.__views.bookshelf!close!stopLoopAudio"] && $.__views.bookshelf.addEventListener("close", stopLoopAudio);
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;