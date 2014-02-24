function StorySlide(_slideData) {
    this.animatedItems = [];
    this.mainView = Ti.UI.createView({
        opacity: 0
    });
    this.slideData = _slideData;
    this.buildElements();
    this.mainView.anima = this.animatedItems;
    this.mainView.imageCount = 0;
    this.mainView.addEventListener("story_slideImage_loaded", this.slideLoaded);
    this.mainView.addEventListener("animarSlide", this.animateSlide);
    return this.mainView;
}

StorySlide.prototype.mainView;

StorySlide.prototype.animatedItems;

StorySlide.prototype.buildElements = function() {
    this.slideData.stageElements || this.errorDetect("stage elements not found");
    _itemsLength = this.slideData.stageElements.length;
    for (var i = 0; _itemsLength > i; i++) {
        var element = this.createSingleElement(this.slideData.stageElements[i], _itemsLength);
        element.zIndex = i;
        element._parent = this.mainView;
        this.mainView.add(element);
    }
};

StorySlide.prototype.createSingleElement = function(_targetElement) {
    _targetElement.type || this.errorDetect("target type not found");
    var currentElement;
    switch (_targetElement.type) {
      case "image":
        _targetElement.properties.image = "/storyAssets/story1/" + _targetElement.properties.image;
        currentElement = Ti.UI.createImageView(_targetElement.properties);
        currentElement.itemCount = _itemsLength;
        currentElement.addEventListener("load", function(e) {
            if (++e.source._parent.imageCount == e.source.itemCount) {
                e.source._parent.fireEvent("story_slideImage_loaded");
                e.source._parent.imageCount = 0;
            }
        });
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

StorySlide.prototype.slideLoaded = function(e) {
    var element = e.source;
    var animation = Titanium.UI.createAnimation({
        opacity: 1,
        duration: 600
    });
    element.animate(animation);
    animation.parentView = element.parentView;
    animation.addEventListener("complete", function(e) {
        e.source.parentView.children.length > 1 && e.source.parentView.remove(e.source.parentView.children[0]);
    });
    element.onStage || element.fireEvent("animarSlide");
};

StorySlide.prototype.errorDetect = function(_alertMessage) {
    alert(_alertMessage);
};

StorySlide.prototype.cleaner = function() {};

module.exports = StorySlide;