function LoaderScreen() {}

LoaderScreen.prototype.getLoader = function() {
    var loadingScreen = Ti.UI.createView({
        zIndex: 100,
        backgroundColor: "#77ffffff",
        width: "100%",
        height: "100%",
        top: 0,
        visible: false,
        left: 0
    });
    var imageIcon = Ti.UI.createImageView({
        width: 140,
        height: 140,
        image: "/loadingScreen/circle.png"
    });
    var iconContainer = Ti.UI.createView({
        width: 140,
        height: 140,
        top: 303,
        left: 0,
        zIndex: 10
    });
    iconContainer.add(imageIcon);
    var loadBar = Ti.UI.createImageView({
        width: 925,
        height: 46,
        top: 406,
        image: "/loadingScreen/loadbar.png"
    });
    var bothContainer = Ti.UI.createView({
        width: 938
    });
    var matrix = Ti.UI.create2DMatrix();
    matrix = matrix.rotate(359);
    var animation = Titanium.UI.createAnimation({
        transform: matrix,
        repeat: 1e3,
        curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
        duration: 4e3
    });
    imageIcon.animate(animation);
    bothContainer.add(loadBar);
    bothContainer.add(iconContainer);
    loadingScreen.add(bothContainer);
    imageIcon.animate(animation);
    return loadingScreen;
};

module.exports = LoaderScreen;