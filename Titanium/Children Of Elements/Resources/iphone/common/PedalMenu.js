function PedalMenu(_titleTarget, _textTarget) {
    this.screenTitle = _titleTarget;
    this.screenText = _textTarget;
    var cirContainer = Ti.UI.createImageView({
        image: "/bookshelf/bookshelf_pedalMenu_container.png",
        left: 0,
        bottom: 0,
        width: 512,
        height: 517,
        touchEnabled: false,
        zIndex: 1
    });
    var petaloContainer = Ti.UI.createView({
        width: 700,
        height: 700,
        bottom: 0,
        left: 0
    });
    petaloContainer.add(cirContainer);
    this.pedalContainerView = petaloContainer;
    this.createPedals();
    return this.pedalContainerView;
}

PedalMenu.prototype.screenTitle;

PedalMenu.prototype.screenText;

PedalMenu.prototype.createPedals = function() {
    var petalos = this.parseJSON("json/pedals.json");
    for (var i = 0; petalos.length > i; i++) {
        var petalo = this.createPedalItem(petalos[i], this.pedalContainerView);
        this.pedalContainerView.add(petalo);
    }
    this.pedalContainerView.addEventListener("resetHighLight", function(e) {
        for (var i = 0; e.source.children.length > i; i++) e.source.children[i].children[1] && (e.source.children[i].children[1].opacity = 0);
    });
};

PedalMenu.prototype.createPedalItem = function(_pedalInfo, _targetParent) {
    var petalo = Ti.UI.createImageView({
        image: "/bookshelf/bookshelf_pedalMenu_pedal_normal.png",
        width: 144,
        height: 160,
        touchEnabled: false
    });
    var petaloActive = Ti.UI.createImageView({
        image: "/bookshelf/bookshelf_pedal_active.png",
        width: 144,
        height: 160,
        touchEnabled: false,
        opacity: 0
    });
    var matrix = Ti.UI.create2DMatrix();
    matrix = matrix.rotate(_pedalInfo.rotacion);
    var pedalItem = Ti.UI.createView({
        width: 144,
        height: 160,
        transform: matrix,
        left: _pedalInfo.left,
        bottom: _pedalInfo.bottom,
        d_titulo: _pedalInfo.titleA,
        storyID: _pedalInfo.storyID
    });
    pedalItem.s_titulo = this.screenTitle;
    pedalItem.s_text = this.screenText;
    pedalItem.active = petaloActive;
    pedalItem._parent = _targetParent;
    pedalItem.add(petalo);
    pedalItem.add(petaloActive);
    pedalItem.addEventListener("click", function(e) {
        e.source._parent.fireEvent("resetHighLight");
        e.source.s_titulo.text = e.source.d_titulo;
        Ti.App.fireEvent("onShowNewStory", {
            storyID: e.source.storyID
        });
        var animation = Titanium.UI.createAnimation({
            opacity: 1,
            duration: 500
        });
        setTimeout(function() {
            e.source.active.animate(animation);
        }, 1e3);
    });
    return pedalItem;
};

PedalMenu.prototype.mostrarTexto = function() {};

PedalMenu.prototype.rotatePedals = function() {
    var matrix = Ti.UI.create2DMatrix();
    matrix = matrix.rotate(180);
    var centre = {
        x: 0,
        y: 1
    };
    this.pedalContainerView.anchorPoint = centre;
    Ti.UI.createAnimation({
        transform: matrix,
        repeat: 100,
        anchorPoint: centre,
        curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
        autoreverse: true,
        duration: 1e3
    });
};

PedalMenu.prototype.parseJSON = function(_URL) {
    var file = Titanium.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, _URL);
    var data = file.read();
    var json = JSON.parse(data.text);
    return json;
};

module.exports = PedalMenu;