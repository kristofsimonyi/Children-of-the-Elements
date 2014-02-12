function Controller() {
    function init() {
        $.inicio.text = args.currentItem.id;
        $.texto.text = "This is a placeholder for the  >" + args.currentItem.id.toUpperCase() + "< planet. There is no layout yet...use your imagination in here :)  ";
        setPlanet();
        showSlide();
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
    function showSlide() {
        var imageSlides = [ "/bookshelf/bookshelf_imageslide_01.jpg", "/bookshelf/bookshelf_imageslide_02.jpg", "/bookshelf/bookshelf_imageslide_03.jpg" ];
        $.bookshelf_slide.images = imageSlides;
        $.bookshelf_slide.start();
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
    $.__views.inicio = Ti.UI.createLabel({
        color: "#000000",
        left: 853,
        top: 120,
        font: {
            fontSize: 44
        },
        text: "Legend of the north",
        id: "inicio"
    });
    $.__views.bookshelf.add($.__views.inicio);
    $.__views.texto = Ti.UI.createLabel({
        color: "#000000",
        left: 853,
        top: 208,
        width: 284,
        font: {
            fontSize: 13
        },
        text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco",
        id: "texto"
    });
    $.__views.bookshelf.add($.__views.texto);
    $.__views.planetImage = Ti.UI.createView({
        top: 366,
        left: -175,
        transform: Alloy.Globals.rotateInterno,
        width: 594,
        height: 520,
        backgroundImage: "/home/home_planet_north.png",
        id: "planetImage"
    });
    $.__views.bookshelf.add($.__views.planetImage);
    $.__views.pedalMenuElement = Ti.UI.createView({
        left: 0,
        bottom: 0,
        borderWidth: 1,
        borderColor: "#ff0000",
        width: 747,
        height: 750,
        id: "pedalMenuElement"
    });
    $.__views.bookshelf.add($.__views.pedalMenuElement);
    $.__views.pedalItems = Ti.UI.createView({
        id: "pedalItems"
    });
    $.__views.pedalMenuElement.add($.__views.pedalItems);
    $.__views.pedal_circleContainer = Ti.UI.createImageView({
        left: 0,
        bottom: 0,
        width: 512,
        height: 517,
        image: "/bookshelf/bookshelf_pedalMenu_container.png",
        id: "pedal_circleContainer"
    });
    $.__views.pedalMenuElement.add($.__views.pedal_circleContainer);
    $.__views.bookshelf_play = Ti.UI.createImageView({
        top: 208,
        left: 1147,
        image: "/bookshelf/bookshelf_buton_play.png",
        id: "bookshelf_play"
    });
    $.__views.bookshelf.add($.__views.bookshelf_play);
    $.__views.bookshelf_slide = Ti.UI.createImageView({
        top: 325,
        left: 849,
        id: "bookshelf_slide"
    });
    $.__views.bookshelf.add($.__views.bookshelf_slide);
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