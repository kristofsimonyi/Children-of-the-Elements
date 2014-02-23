function StoryNavigator(_storySlides) {
    this.storyView = Ti.UI.createView();
    0 >= _storySlides.length ? this.errorManager("empty slide array") : this.storySlides = _storySlides;
}

StoryNavigator.prototype.storySlides;

StoryNavigator.prototype.storyView;

StoryNavigator.prototype.contentCount;

StoryNavigator.prototype.init = function() {
    this.loadSlide(0);
    this.contentCount = 0;
    return this.storyView;
};

StoryNavigator.prototype.next = function() {
    if (this.contentCount + 1 < this.storySlides.length) {
        this.contentCount++;
        this.loadSlide(this.contentCount);
    }
};

StoryNavigator.prototype.back = function() {
    if (this.contentCount - 1 >= 0) {
        this.contentCount--;
        this.loadSlide(this.contentCount);
    }
};

StoryNavigator.prototype.loadSlide = function(_slideID) {
    this.storySlides[_slideID].backgroundColor = "#ffffff";
    this.storySlides[_slideID].parentView = this.storyView;
    this.storySlides[_slideID].opacity = 0;
    this.storyView.add(this.storySlides[_slideID]);
    this.storySlides[_slideID].onStage && this.storySlides[_slideID].fireEvent("story_slideImage_loaded");
};

StoryNavigator.prototype.errorManager = function(_message) {
    alert(_message);
};

module.exports = StoryNavigator;