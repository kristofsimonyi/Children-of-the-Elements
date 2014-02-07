var args = arguments[0] || {};
// $.label.text = args.foobar;
var currentItem = args.currentItem


function init(){

	$.inicio.text = args.currentItem.id;

	setPlanetPosition()

}


function setPlanetPosition(){

	$.planetImage.top = args.currentItem.top;
	$.planetImage.left = args.currentItem.left;
	$.planetImage.transform = args.currentItem.transform;
	$.planetImage.width = args.currentItem.width;
	$.planetImage.height = args.currentItem.height;
	$.planetImage.backgroundImage = args.currentItem.backgroundImage;
	
}





init();

