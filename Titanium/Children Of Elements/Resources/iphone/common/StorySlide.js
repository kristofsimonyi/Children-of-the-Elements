function StorySlide(_slideData) {
    this.animatedItems = [];
    this.mainView = Ti.UI.createView();
    this.slideData = _slideData;
    this.mainView.add(this.buildElements());
    this.mainView.anima = this.animatedItems;
    this.mainView.addEventListener("animarSlide", this.animateSlide);
    return this.mainView;
}

StorySlide.prototype.mainView;

StorySlide.prototype.animatedItems;

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
        break;

      default:
        Ti.API.info("create single element, type not found");
    }
    if (_targetElement.animation) {
        var itemAnimation = this.animations(_targetElement.animation);
        currentElement._innerAnimation = itemAnimation;
        this.animatedItems.push(currentElement);
    }
    if (_targetElement.alertOnClick) {
        currentElement._msg = _targetElement.alertOnClick;
        currentElement.addEventListener("click", function() {});
    } else currentElement.touchEnabled = false;
    return currentElement;
};

StorySlide.prototype.animations = function(_animData) {
    var matrix = Ti.UI.create2DMatrix();
    if (_animData.rotate) {
        matrix = matrix.rotate(90);
        _animData.transform = matrix;
    }
    _animData.rotate = null;
    _animData.scale = null;
    var _animation = Ti.UI.createAnimation(_animData);
    return _animation;
};

StorySlide.prototype.animateSlide = function(e) {
    for (var i = 0; e.source.anima.length > i; i++) {
        var element = e.source.anima[i];
        element.animate(element._innerAnimation);
    }
    e.source.removeEventListener("animarSlide", function() {});
};

StorySlide.prototype.errorDetect = function(_alertMessage) {
    alert(_alertMessage);
};

StorySlide.prototype.cleaner = function() {};

module.exports = StorySlide;