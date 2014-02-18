function PedalMenu(_titleTarget, _textTarget) {
    this.screenTitle = _titleTarget;
    this.screenText = _textTarget;
    Ti.App.addEventListener("clickPetalo", function() {});
    return this.createPedals();
}

PedalMenu.prototype.screenTitle;

PedalMenu.prototype.screenText;

PedalMenu.prototype.createPedals = function() {
    var petalos = this.parseJSON("/json/pedals.json");
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
        if (petalos[i].imagenActiva) {
            imagenPetaloBase = petalos[i].imagenActiva;
            imagenW = 224;
            imagenH = 257;
        } else {
            imagenPetaloBase = "/bookshelf/bookshelf_pedalMenu_pedal_normal.png";
            imagenW = 144;
            imagenH = 160;
        }
        var petalo = Ti.UI.createImageView({
            image: imagenPetaloBase
        });
        var matrix = Ti.UI.create2DMatrix();
        matrix = matrix.rotate(petalos[i].rotacion);
        petalo.width = imagenW;
        petalo.height = imagenH;
        petalo.left = petalos[i].left;
        petalo.bottom = petalos[i].bottom;
        petalo.transform = matrix;
        petalo.s_titulo = this.screenTitle;
        petalo.s_text = this.screenText;
        petalo.d_titulo = petalos[i].titleA;
        petalo.addEventListener("click", function(e) {
            e.source.s_titulo.text = e.source.d_titulo;
            e.source.s_text.text = "THIS IS A PLACEHOLDER Lorem ipsum dolor sit amet, consectetur ";
        });
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

PedalMenu.prototype.parseJSON = function(_URL) {
    var file = Titanium.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, _URL);
    var data = file.read().text;
    var json = JSON.parse(data);
    return json;
};

module.exports = PedalMenu;