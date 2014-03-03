function ItemTransition(_transitionInfo) {
    this.transitionInfo = _transitionInfo;
    return this.createSlide();
}

ItemTransition.prototype.transitionInfo;

ItemTransition.prototype.vierContainer;

ItemTransition.prototype._slideContainer;

ItemTransition.prototype._slideInterval;

ItemTransition.prototype.createSlide = function() {
    this._slideContainer = Titanium.UI.createView(this.transitionInfo.properties);
    var imageSlides = this.transitionInfo.images;
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

ItemTransition.prototype.slideShowStart = function(_arrayTarget, _viewTarget) {
    var val = _arrayTarget.length - 1;
    ItemTransition.prototype._slideInterval = setInterval(function() {
        function reposition(e) {
            if (e.source.parentView.children.length > 1) {
                e.source.parentView.children[0].opacity = 0;
                e.source.parentView.remove(e.source.parentView.children[0]);
            }
            animation.removeEventListener("complete", reposition);
        }
        0 > val && (val = _arrayTarget.length - 1);
        var animation = Titanium.UI.createAnimation({
            opacity: 1,
            duration: 3e3
        });
        var animationOUT = Titanium.UI.createAnimation({
            opacity: 0,
            duration: 1500
        });
        animation._target = _arrayTarget[val];
        animation.parentView = _viewTarget;
        animationOUT.parentView = _viewTarget;
        _viewTarget.add(_arrayTarget[val]);
        _arrayTarget[val].animate(animation);
        _viewTarget.children[1] && _viewTarget.children[0].animate(animationOUT);
        val -= 1;
        Ti.API.info("TOC");
        animationOUT.addEventListener("complete", reposition);
    }, 3200);
};

module.exports = ItemTransition;