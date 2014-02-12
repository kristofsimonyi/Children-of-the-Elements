function SlideShow() {
    return this.createSlide();
}

SlideShow.prototype._slideContainer;

SlideShow.prototype.createSlide = function() {
    this._slideContainer = Titanium.UI.createView();
    this._slideContainer.top = 325;
    this._slideContainer.left = 849;
    var imageSlides = [ "/bookshelf/bookshelf_imageslide_01.jpg", "/bookshelf/bookshelf_imageslide_02.jpg", "/bookshelf/bookshelf_imageslide_03.jpg" ];
    var slideViews = [];
    for (var i = 0; imageSlides.length > i; i++) {
        var imageItem = Ti.UI.createImageView({
            image: imageSlides[i]
        });
        imageItem.bottom = 0;
        imageItem.right = 0;
        imageItem.zIndex = 1;
        imageItem.opacity = 0;
        imageItem.id = "elemento" + [ i ];
        slideViews.push(imageItem);
    }
    this.slideShowStart(slideViews, this._slideContainer);
    return this._slideContainer;
};

SlideShow.prototype.slideShowStart = function(_arrayTarget, _viewTarget) {
    var val = _arrayTarget.length - 1;
    setInterval(function() {
        function reposition(e) {
            2 == e.source.parentView.children.length && e.source.parentView.remove(e.source.parentView.children[0]);
            animation.removeEventListener("complete", reposition);
        }
        0 > val && (val = _arrayTarget.length - 1);
        _arrayTarget[val].zIndex = _arrayTarget[val].zIndex + 1;
        var animation = Titanium.UI.createAnimation({
            opacity: 1,
            curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
            duration: 1e3
        });
        animation._target = _arrayTarget[val];
        animation.parentView = _viewTarget;
        _viewTarget.add(_arrayTarget[val]);
        _arrayTarget[val].animate(animation);
        val -= 1;
        animation.addEventListener("complete", reposition);
    }, 5e3);
};

module.exports = SlideShow;