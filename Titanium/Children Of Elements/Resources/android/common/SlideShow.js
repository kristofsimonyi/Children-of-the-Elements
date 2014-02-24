function SlideShow() {
    Ti.App.addEventListener("stopSlideShow", function() {
        clearInterval(SlideShow.prototype._slideInterval);
        SlideShow.prototype._slideInterval = null;
    });
    return this.createSlide();
}

SlideShow.prototype._slideContainer;

SlideShow.prototype._slideInterval;

SlideShow.prototype.createSlide = function() {
    this._slideContainer = Titanium.UI.createView();
    this._slideContainer.width = "431dip";
    this._slideContainer.height = "426dip";
    var imageSlides = [ "/bookshelf/bookshelf_imageslide_01.jpg", "/bookshelf/bookshelf_imageslide_02.jpg", "/bookshelf/bookshelf_imageslide_03.jpg" ];
    var slideViews = [];
    for (var i = 0; imageSlides.length > i; i++) {
        var imageItem = Ti.UI.createImageView({
            image: imageSlides[i]
        });
        imageItem.width = Ti.UI.FILL;
        imageItem.height = Ti.UI.FILL;
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
    SlideShow.prototype._slideInterval = setInterval(function(e) {
        function reposition(e) {
            if (2 == e.source.parentView.children.length) {
                e.source.parentView.children[0].opacity = 0;
                e.source.parentView.remove(e.source.parentView.children[0]);
            }
            animation.removeEventListener("complete", reposition);
        }
        if (0 > val) {
            val = _arrayTarget.length - 1;
            Ti.App.fireEvent("stopSlideShow", {
                custom_data: e
            });
        }
        var animation = Titanium.UI.createAnimation({
            opacity: 1,
            duration: 1e3
        });
        animation._target = _arrayTarget[val];
        animation.parentView = _viewTarget;
        _viewTarget.add(_arrayTarget[val]);
        _arrayTarget[val].animate(animation);
        val -= 1;
        Ti.API.info("TOC");
        animation.addEventListener("complete", reposition);
    }, 3e3);
};

module.exports = SlideShow;