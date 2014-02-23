function StoryBuilder(_storyID) {
    var _data = this.parseJSON("json/story" + _storyID + ".json");
    var _slides = [];
    for (var i = 0; _data.length > i; i++) _slides.push(new Slide(_data[i]));
    return _slides;
}

var Slide = require("/common/StorySlide");

var _slides;

StoryBuilder.prototype.parseJSON = function(_URL) {
    var file = Titanium.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, _URL);
    var data = file.read();
    var json = JSON.parse(data.text);
    return json;
};

module.exports = StoryBuilder;