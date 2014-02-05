function doClick(e) {
    alert($.label.text);
}
//// OPEN THE VIEW
$.index.open({
	fullscreen:true,
	navBarHidden : true
});

var player;
var selectedPlanet;


/// play sound on load
function playLoopAudio(){
	
	player = Ti.Media.createSound({url:"/audio/loopTest.mp3", looping:true});
	player.looping = true; 
	player.play();
	
	
}

function stopLoopAudio(){
	player.stop();
}


function selectPlanet(e){
	
	if( e.source.activePlanet == true){
		//showPlanets(e); 
	}else{
		//hidePlanets(e);		
	}
	hidePlanets(e);
	e.source.activePlanet = !e.source.activePlanet;
	
}

function showPlanets(e){
	
	var selectedElement = e.source;
	
	selectedElement.height = 	selectedElement.originalHeight;
	selectedElement.width = 	selectedElement.originalWidth;
	selectedElement.top = 		selectedElement.originalTop;
	selectedElement.transform = selectedElement.originalTransform;
	selectedElement.bottom = 	selectedElement.originalBottom;
	selectedElement.left =  	selectedElement.originalLeft;
	selectedElement.right = 	selectedElement.originalRight;
	
	/// get the planets back to screen
	var selectedPlanet = selectedElement.id.toString();
	if ($.index.children) {
        
         
        for (var c = 0; c < $.index.children.length ; c++) {
        
        		
  				//var identificacion = $.index.children[c].id.toString(); 
  				 
  				$.index.children[c].visible = true;
  				
		        
        
           
        }
        
    }
    
	 
}

function hidePlanets(e){

	/// store element properties
	e.source.originalHeight = e.source.height;
	e.source.originalWidth = e.source.width;
	e.source.originalTop = e.source.top;
	e.source.originalTransform = e.source.transform;
	e.source.originalBottom = e.source.bottom;
	e.source.originalLeft = e.source.left;
	e.source.originalRight = e.source.right;
	 
	///transform the selected Planet
	/**@TODO make this animated * /

	e.source.width = 564;
	e.source.height = 500;
	e.source.top = "5%";
	e.source.layout = "center";
	e.source.left = '25%';
	e.source.right = null;
	
	
	regularRotation = Ti.UI.create2DMatrix().rotate(0);	
	e.source.transform = regularRotation;
	 
	
	var posX = ( Titanium.Platform.displayCaps.platformWidth - (e.source.width) ) / 2;
	
	 var matrix = Ti.UI.create2DMatrix();
	  matrix = matrix.rotate(0);
	  matrix = matrix.scale(2, 2);
	  
	  var a = Ti.UI.createAnimation({
	    transform : matrix,
	    duration : 2000
	  });
	  */
	var matrix = Ti.UI.create2DMatrix();
	  matrix = matrix.rotate(0);
	  matrix = matrix.scale(2, 2);
	  
	 
	  
	  
	
	var animation = Titanium.UI.createAnimation({
		top:'30%',
		left:'40%',
		transform:matrix,
		curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
		duration: 2000
	});
	
	
 
	
	var animationHandler = function() {
	  //animation.removeEventListener('complete',animationHandler);
	  //animation.backgroundColor = 'orange';
	  //view.animate(animation);
	};
	//animation.addEventListener('complete',animationHandler);
 
	  
	  e.source.animate(animation);
	  
	
	
	
	
	
	
	
	
	/// now move other planets off the screen
	
	var selectedElement = e.source.id.toString();
	if ($.index.children) {
        
         
        for (var c = 0; c < $.index.children.length ; c++) {
        
        		// object cache
        		var currentItem = $.index.children[c];

        		//retrieve info from object
  				var itemID = currentItem.id.toString();
  				 

  				var matrix = Ti.UI.create2DMatrix();
					matrix = matrix.rotate(currentItem.preferedRotationBase);
					matrix = matrix.scale(1,1);
  				

  				 Ti.API.info(currentItem.preferedRightPosition)
  				      
		        if( itemID != selectedElement  ){


		         		 currentItem.animate({
		         		 	top: 500,
		         		 	left: 500,
		         		 	right: currentItem.preferedRightPosition,
		         		 	bottom: currentItem.peferedBottomPosition,
		         		 	transform:matrix,
		         		 	curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
		         		 	duration:1000});

		         		 
		        }else{
		        	Ti.API.info( $.index.children[c].id + " " + e.source.id );
		        }


		        currentItem = null;
		        matrix = null;
        
           
        }
        
    }
	
	
}
