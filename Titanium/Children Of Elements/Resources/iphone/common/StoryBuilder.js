function StoryBuilder(_storyID) {
    var _data = this.parseJSON("/json/story" + _storyID + ".json");
    var _slides = Ti.UI.createView();
    for (var i = 0; _data.length > i; i++) _slides.add(new Slide(_data[i]));
    return _slides;
}

var Slide = require("/common/StorySlide");

var _slides;

StoryBuilder.prototype.parseJSON = function(_URL) {
    var file = Titanium.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, _URL);
    var data = file.read().text;
    var json = JSON.parse(data);
    return json;
};

module.exports = StoryBuilder;