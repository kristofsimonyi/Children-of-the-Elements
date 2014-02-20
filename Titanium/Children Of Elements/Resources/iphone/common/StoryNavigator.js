function StoryNavigator(_storySlides) {
    this.storyView = Ti.UI.createView();
    0 >= _storySlides.length ? this.errorManager("empty slide array") : this.storySlides = _storySlides;
}

StoryNavigator.prototype.storySlides;

StoryNavigator.prototype.storyView;

StoryNavigator.prototype.contentCount;

StoryNavigator.prototype.init = function() {
    this.storyView.add(this.storySlides[0]);
    this.contentCount = 0;
    return this.storyView;
};

StoryNavigator.prototype.next = function() {
    if (this.contentCount + 1 < this.storySlides.length) {
        this.contentCount++;
        alert(this.contentCount);
    }
};

StoryNavigator.prototype.back = function() {
    if (this.contentCount - 1 >= 0) {
        this.contentCount--;
        alert(this.contentCount);
    }
};

StoryNavigator.prototype.errorManager = function(_message) {
    alert(_message);
};

module.exports = StoryNavigator;