var SETRATING_PRODUCT_ACTION = "/interaction/ajax/setProductRating.do";
var SETRATING_ARTIST_ACTION = "/interaction/ajax/setArtistRating.do";

/** ARRAY DE RATINGMANAGER **/
RatingArray = function() {
	this.items = new Array();
	this.itemsId = new Array();
};

RatingArray.prototype.addArray = function(ratingId, itemId, saveVar, ajaxUrl, ratingStatus) { // item
	this.items.push(new RatingManager(ratingId, itemId, saveVar, ajaxUrl, ratingStatus));//item
	this.itemsId.push(ratingId);
};

RatingArray.prototype.resolveManager = function(ratingId) {
	for(var i=0; i<= this.items.length; i++) {
		if (ratingId == this.itemsId[i]) {
			return this.items[i];
		}
	}
}

/** RATINGMANAGER **/
RatingManager = function(ratingId, itemId, saveVar, ajaxUrl, ratingStatus) {//item
	this.ratingId = ratingId;
	this.itemId = itemId;
	this.saveVar = saveVar;
	this.ajaxUrl = ajaxUrl;
	this.ratingStatus = ratingStatus;
};

RatingManager.prototype.saveRatingProduct = function(rating) {
	if (!loginsubacookie.isCooked()) {
		loginsubacookie.redirectNotCooked();
		return;
	}
	if (this.saveVar == "") {
		this.saveRatingProductAjax(rating);
	}else {
		eval(this.saveVar).value = rating;
		this.colorRating(rating);
	}
};
/* ==============================================================
                    parte de artistas Inicio
88888888888888888888888888888888888888888888888888888888888888888*/
RatingManager.prototype.saveRatingArtist = function(rating) {
	if (!loginsubacookie.isCooked()) {
		loginsubacookie.redirectNotCooked();
		return;
	}
	if (this.saveVar == "") {
		this.saveRatingArtistAjax(rating);
	}else {
		eval(this.saveVar).value = rating;
		this.colorRating(rating);
	}
};
RatingManager.prototype.saveRatingArtistAjax = function(rating) {
	var params = "artistId=" + this.itemId + "&rating=" + rating;
	var callbackSuccess = ratingArray.resolveManager(this.ratingId).setRatingItemSuccessCallback;
	var callbackFailure = ratingArray.resolveManager(this.ratingId).setRatingItemFailedCallback;	
	var manager = this;
	
	var request = new Ajax.Request(
		this.ajaxUrl + SETRATING_ARTIST_ACTION,
		{
			method: "post",
			parameters: params, 
			onSuccess: function(request) {
						    callbackSuccess(request, manager);
					    },
   			onFailure: function(request) {
   							callbackFailure(request, manager);
   						}
		});			
};
/* ==============================================================
                    parte de artistas Fim
88888888888888888888888888888888888888888888888888888888888888888*/


/*===================== SET PRODUCT RATING =================*/
RatingManager.prototype.saveRatingProductAjax = function(rating) {
	var params = "productId=" + this.itemId + "&rating=" + rating;
	var callbackSuccess = ratingArray.resolveManager(this.ratingId).setRatingItemSuccessCallback;
	var callbackFailure = ratingArray.resolveManager(this.ratingId).setRatingItemFailedCallback;	
	var manager = this;
	if (manager.ratingStatus != "") {
			document.getElementById(manager.ratingStatus).innerHTML = "Aguarde";
	}
	var request = new Ajax.Request(
		this.ajaxUrl + SETRATING_PRODUCT_ACTION,
		{
			method: "post",
			parameters: params, 
			onSuccess: function(request) {
						    callbackSuccess(request, manager);
					    },
   			onFailure: function(request) {
   							callbackFailure(request, manager);
   						}
		});			
};

RatingManager.prototype.setRatingItemSuccessCallback = function(request, manager) {
	var json =  request.responseText.evalJSON();
	
	requestStatusOk = json.responseParameters.requestStatusOk;
	requestStatusError = json.responseParameters.requestStatusError;
	requestStatus = json.responseParameters.requestStatus;
	
	var rating = json.responseParameters.rating;

	if(requestStatusOk != null && requestStatus == requestStatusOk) {
		if (manager.ratingStatus != "") {
			document.getElementById(manager.ratingStatus).innerHTML = "Ok";
		}
		manager.colorRating(rating);
	}
	else {
		var requestErrorStatusCode = json.responseParameters.requestErrorStatusCode;
		if (requestErrorStatusCode == "customerUnauthenticated" || requestErrorStatusCode == "customerNotCooked") {
			
		}else{
			setRatingItemFailedCallback(request, manager);
		}
	}
};

RatingManager.prototype.setRatingItemFailedCallback = function(request, manager) {
	var json =  request.responseText.evalJSON();
	if (manager.ratingStatus != "") {
		document.getElementById(manager.ratingStatus).innerHTML = "Erro";
	}
};

/*===================== INTERNAL COMPONENT FUNCIONS =================*/
RatingManager.prototype.colorRating = function(rating) {
	for (var i =0; i <=5; i++) {
		var level = document.getElementById(this.ratingId + "Sub" + i);
		var index = level.className.indexOf("selected");
		if (index >= 0) {
			if (rating != i)
				level.className = level.className.substring(0,index);
		}
		else {
			if (rating == i) {
				level.className = level.className + " selected";
				document.getElementById(this.ratingId + "Selected").value = rating;
			}
		}
	}
};

RatingManager.prototype.ratingDeselect = function() {
	var sel = document.getElementById(this.ratingId + "Selected").value;
	if (sel > -1 && sel != "") {
		var level = document.getElementById(this.ratingId + "Sub" + sel);
		var index = level.className.indexOf("selected");
		if (index >= 0) {
			level.className = level.className.substring(0,index);
		}
	}
};

RatingManager.prototype.ratingReselect = function() {
	var sel = document.getElementById(this.ratingId + "Selected").value;
	if (sel > -1 && sel != "") {
		var level = document.getElementById(this.ratingId + "Sub" + sel);
		level.className = level.className + " selected";
	}
};

var ratingArray = new RatingArray();