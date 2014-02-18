function StorySlide(_slideData) {
    var prueba = Ti.UI.createLabel({
        text: _slideData.background,
        top: _slideData.top
    });
    return prueba;
}

module.exports = StorySlide;