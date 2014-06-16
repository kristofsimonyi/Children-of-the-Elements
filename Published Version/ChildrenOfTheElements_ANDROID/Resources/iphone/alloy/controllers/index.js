function Controller() {
    function init() {
        function updateMenu(updateNeeded) {
            if (true == updateNeeded) {
                var menuFiles = [ "bookshelfData/north_menu.json" ];
                var list = downloader.makeQueue(menuFiles, "bookshelfData");
                downloader.downloadMultiFile(list, filesReady, filesDone);
            } else filesDone();
        }
        function filesReady() {}
        function filesDone() {
            var fakePlanet = {
                id: "north"
            };
            openBookshelf(fakePlanet);
        }
        Ti.App.Properties.getString("lastUpdate") || Ti.App.Properties.setString("lastUpdate", "March 13, 2014 11:36");
        verifyLanguage();
        defineSystemFonts();
        var imageDir = Ti.Filesystem.getFile(Titanium.Filesystem.applicationDataDirectory, "bookshelfData");
        imageDir.exists() || imageDir.createDirectory();
        var downloader = new FileDownloader();
        downloader.checkUpdate(updateMenu);
    }
    function openBookshelf(_target) {
        currentID = _target.id.toString();
        var bookshelfx = Alloy.createController("bookshelf", {
            currentItem: _target,
            prev: $.index
        }).getView();
        bookshelfx.open({
            fullscreen: true,
            navBarHidden: true,
            exitOnClose: false
        });
    }
    function defineSystemFonts() {
        var _systemFonts = new FontDictionary();
        _systemFonts.init();
    }
    function verifyLanguage() {
        Alloy.Globals.userLanguage = "es" == Titanium.Locale.currentLanguage ? "es" : "en";
        Ti.App.Properties.getString("sysLang") && Ti.App.Properties.getString("sysLang") != Alloy.Globals.userLanguage && Ti.App.Properties.setString("lastUpdate", "March 13, 2014 11:36");
        Ti.App.Properties.setString("sysLang", Alloy.Globals.userLanguage);
    }
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "index";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    $.__views.index = Ti.UI.createWindow({
        backgroundImage: "/home/background_home.png",
        layout: "center",
        fullscreen: "true",
        id: "index"
    });
    $.__views.index && $.addTopLevelView($.__views.index);
    exports.destroy = function() {};
    _.extend($, $.__views);
    var Flurry = require("com.onecowstanding.flurry");
    var FontDictionary = require("/common/CreateFontDictionary");
    Flurry.appVersion = Ti.App.version;
    "android" == Ti.Platform.osname ? Flurry.startSession("9QN2KZPGD9C36VC252FW") : Flurry.startSession("SNF2V3NZ6TRXKY8ZCVZ2");
    Flurry.debugLogEnabled = true;
    Flurry.eventLoggingEnabled = true;
    Flurry.sessionReportsOnCloseEnabled = true;
    Flurry.sessionReportsOnPauseEnabled = true;
    Flurry.sessionReportsOnActivityChangeEnabled = true;
    Flurry.secureTransportEnabled = false;
    Flurry.logPageView();
    var FileDownloader = require("/common/FileDownloader");
    init();
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;