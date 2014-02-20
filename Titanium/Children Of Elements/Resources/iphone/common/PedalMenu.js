function PedalMenu(_titleTarget, _textTarget) {
    this.screenTitle = _titleTarget;
    this.screenText = _textTarget;
    return this.createPedals();
}

PedalMenu.prototype.screenTitle;

PedalMenu.prototype.screenText;

PedalMenu.prototype.createPedals = function() {
    var petalos = this.parseJSON("json/pedals.json");
    var petaloContainer = Ti.UI.createView({
        width: 700,
        height: 700,
        bottom: 0,
        left: 0
    });
    for (var i = 0; petalos.length > i; i++) {
        var imagenPetaloBase;
        var imagenW;
        var imagenH;
        if (petalos[i].imageActive) {
            imagenPetaloBase = petalos[i].imagenActiva;
            imagenW = 224;
            imagenH = 257;
        } else {
            imagenPetaloBase = "/bookshelf/bookshelf_pedalMenu_pedal_normal.png";
            imagenW = 144;
            imagenH = 160;
        }
        var petalo = this.createPedalItem(petalos[i]);
        petaloContainer.add(petalo);
    }
    var cirContainer = Ti.UI.createImageView({
        image: "/bookshelf/bookshelf_pedalMenu_container.png",
        left: 0,
        bottom: 0,
        width: 512,
        height: 517,
        touchEnabled: false
    });
    petaloContainer.add(cirContainer);
    this.pedalContainerView = petaloContainer;
    this.rotatePedals();
    return petaloContainer;
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

PedalMenu.prototype.createPedalItem = function(_pedalInfo) {
    var petalo = Ti.UI.createImageView({
        image: "/bookshelf/bookshelf_pedalMenu_pedal_normal.png",
        width: 144,
        height: 160,
        touchEnabled: false
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
    pedalItem.add(petalo);
    pedalItem.addEventListener("click", function(e) {
        e.source.s_titulo.text = e.source.d_titulo;
        Ti.App.fireEvent("onShowNewStory", {
            storyID: e.source.storyID
        });
    });
    return pedalItem;
};

PedalMenu.prototype.parseJSON = function(_URL) {
    var file = Titanium.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, _URL);
    var data = file.read();
    alert(file);
    alert(data.text);
    var json = JSON.parse(data.text);
    return json;
};

module.exports = PedalMenu;