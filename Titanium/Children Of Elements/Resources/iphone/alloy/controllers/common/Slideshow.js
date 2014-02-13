function Controller() {
    function Controller() {
        function SlideShow() {
            alert("yolo");
        }
        require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
        this.__controllerPath = "common/SlideShow";
        arguments[0] ? arguments[0]["__parentSymbol"] : null;
        arguments[0] ? arguments[0]["$model"] : null;
        arguments[0] ? arguments[0]["__itemTemplate"] : null;
        var $ = this;
        var exports = {};
        exports.destroy = function() {};
        _.extend($, $.__views);
        SlideShow.prototype.showSlide = function() {};
        module.exports = SlideShow;
        _.extend($, exports);
    }
    require("alloy/controllers/BaseController").apply(this, Array.prototype.slice.call(arguments));
    this.__controllerPath = "common/Slideshow";
    arguments[0] ? arguments[0]["__parentSymbol"] : null;
    arguments[0] ? arguments[0]["$model"] : null;
    arguments[0] ? arguments[0]["__itemTemplate"] : null;
    var $ = this;
    var exports = {};
    exports.destroy = function() {};
    _.extend($, $.__views);
    var Alloy = require("alloy"), _ = (Alloy.Backbone, Alloy._);
    module.exports = Controller;
    _.extend($, exports);
}

var Alloy = require("alloy"), Backbone = Alloy.Backbone, _ = Alloy._;

module.exports = Controller;