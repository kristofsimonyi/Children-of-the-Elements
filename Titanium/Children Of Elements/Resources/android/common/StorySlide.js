function StorySlide(_slideData) {
    this.mainView = Ti.UI.createView();
    this.slideData = _slideData;
    this.mainView.add(this.buildElements());
    return this.mainView;
}

StorySlide.prototype.mainView;

StorySlide.prototype.buildElements = function() {
    this.slideData.stageElements || this.errorDetect("stage elements not found");
    var elementsPreWrap = Ti.UI.createView();
    for (var i = 0; this.slideData.stageElements.length > i; i++) {
        var element = this.createSingleElement(this.slideData.stageElements[i]);
        element.zIndex = i;
        elementsPreWrap.add(element);
    }
    return elementsPreWrap;
};

StorySlide.prototype.createSingleElement = function(_targetElement) {
    _targetElement.type || this.errorDetect("target type not found");
    var currentElement;
    switch (_targetElement.type) {
      case "image":
        var newImg = "/storyAssets/story1/" + _targetElement.properties.image;
        _targetElement.properties.image = newImg;
        currentElement = Ti.UI.createImageView(_targetElement.properties);
        currentElement.addEventListener("load", function() {
            alert("loadef");
        });
        break;

      default:
        Ti.API.info("create single element, type not found");
    }
    if (_targetElement.animation) {
        var itemAnimation = this.animations(_targetElement.animation);
        currentElement.animate(itemAnimation);
    }
    return currentElement;
};

StorySlide.prototype.animations = function(_animData) {
    Ti.API.info(_animData);
    Ti.API.info("==========");
    _animData.rotate = null;
    _animData.scale = null;
    Ti.API.info(_animData);
    var _animation = Ti.UI.createAnimation(_animData);
    return _animation;
};

StorySlide.prototype.errorDetect = function(_alertMessage) {
    alert(_alertMessage);
};

module.exports = StorySlide;