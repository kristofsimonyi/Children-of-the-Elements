function PedalMenu(_titleTarget , _textTarget){

	this.screenTitle = _titleTarget;
	this.screenText = _textTarget;

	Ti.App.addEventListener('clickPetalo', function(){
		
	} )
	return this.createPedals();
}

PedalMenu.prototype.screenTitle;
PedalMenu.prototype.screenText;

PedalMenu.prototype.createPedals = function (){

	petalo1 = {"left":"-5", "bottom":"500" , "rotacion":"0" , "titleA": "FIRST STORY"};
	petalo2 = {"left":"160", "bottom":"460" , "rotacion":"18" , "titleA": "SECOND STORY"};
	petalo3 = {"left":"300", "bottom":"320" , "rotacion":"45" , "titleA": "THIRD STORY" , "imagenActiva" : "/bookshelf/bookshelf_pedal_active_img.png"};
	petalo4 = {"left":"430", "bottom":"180" , "rotacion":"72" , "titleA": "FOURTH STORY"};
	petalo5 = {"left":"480", "bottom":"5" , "rotacion":"90" , "titleA": "FIFTH STORY"};

	 


	var petalos = [petalo1, petalo2, petalo3, petalo4, petalo5];


	var petaloContainer = Ti.UI.createView()
	

	for (var i = 0; i < petalos.length; i++) {


		



		var imagenPetaloBase
		var imagenW
		var imagenH 

		if (petalos[i].imagenActiva){
		
			imagenPetaloBase  = petalos[i].imagenActiva;
			imagenW = 224
			imagenH = 257

		}else{

			imagenPetaloBase =  "/bookshelf/bookshelf_pedalMenu_pedal_normal.png";
			imagenW = 144;
			imagenH = 160;
			
		}
	
		var petalo = Ti.UI.createImageView({image:imagenPetaloBase});
	

			var matrix = Ti.UI.create2DMatrix();
				matrix = matrix.rotate(petalos[i].rotacion); //340


			petalo.width = imagenW;
			petalo.height = imagenH ;
			petalo.left = petalos[i].left;
			petalo.bottom = petalos[i].bottom;
			petalo.transform = matrix;
			petalo.s_titulo = this.screenTitle;
			petalo.s_text = this.screenText;
			petalo.d_titulo = petalos[i].titleA
	  

			petalo.addEventListener('click', function(e){
				//Ti.App.fireEvent('clickPetalo', {evento:e});

				e.source.s_titulo.text = e.source.d_titulo;
				e.source.s_text.text = "THIS IS A PLACEHOLDER Lorem ipsum dolor sit amet, consectetur " 

			});


			petaloContainer.add(petalo);
	};


	/// agregar imagen
	var cirContainer = Ti.UI.createImageView({
		image:"/bookshelf/bookshelf_pedalMenu_container.png",
		left:0,
		bottom:0,
		width:512,
		height:517,
		touchEnabled:false,
	})

	petaloContainer.add(cirContainer);

	return  petaloContainer;

}


PedalMenu.prototype.mostrarTexto = function (){
	
}


module.exports = PedalMenu;