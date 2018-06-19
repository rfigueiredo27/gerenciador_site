var MEU_SUBMARINO_HOST = "/ms";

getAjaxHost = function() {
	return "http://" + window.location.hostname;
};

createReview = function() {
	
	var url = getAjaxHost()+MEU_SUBMARINO_HOST+"/review/ajax/createReview.do";
	var validated = "true";
	
	$('problemsVaditadion').hide();
	$('alertRatingProduct').hide();
	$('alertReviewTitle').hide();
	$('alertReviewDescription').hide();
	$('alertCustomerName').hide();
	$('reviewTitle').setAttribute("class", "type4");
	$('reviewDescription').setAttribute("class", "type4");
	$('customerName').setAttribute("class", "type4");
	
	var title =  $("reviewTitle").getValue();
	if(title == null || title == ""){
		$('alertReviewTitle').show();
		$('reviewTitle').setAttribute("class", "type4 formAttention");
		validated = "false";
	}
	
	var customerName = $("customerName").getValue();
	if (customerName == null ||  customerName == ""){
		$('alertCustomerName').show();
		$('customerName').setAttribute("class", "type4 formAttention");
		validated = "false";
	}
	
	var savedrating =  $("rating").getValue();
	if (savedrating <= 0){
		$('alertRatingProduct').show();
		validated = "false";
	}
	
	var review =  $("reviewDescription").getValue();
	if(review == null || review == ""){
		$('alertReviewDescription').show();
		$('reviewDescription').setAttribute("class", "type4 formAttention");
		validated = "false";
	}
	
	if (validated == "true") {
		var publishPersonalData = false;
		if ( $("reviewPersData").checked)
			var publishPersonalData = true;
		
		var reviewId =  $("reviewId").getValue();
		var productId= $("productId").getValue();
		var rating =  $("rating").getValue();
		
		var customerState =  $("customerState").getValue();
		var customerCity =  $("customerCity").getValue();
		var customerEmail =  $("customerEmail").getValue();
		
		var paramsHash = new Hash();
		paramsHash.set('reviewId', reviewId);
		paramsHash.set('productId', productId);
		paramsHash.set('title', title);
		paramsHash.set('review', review);
		paramsHash.set('publishPersonalData', publishPersonalData);
		paramsHash.set('rating', rating);
		paramsHash.set('customerName', customerName);
		paramsHash.set('customerState', customerState);
		paramsHash.set('customerCity', customerCity);
		paramsHash.set('customerEmail', customerEmail);
		
		var request = new Ajax.Request(
								url,
								{
									method: "post",
									parameters: paramsHash.toQueryString(),
									onSuccess: saveReviewSuccessCallback,	
									onFailure: saveReviewFailedCallback
								}
		);
		$('reviewStatusMessage').show();
		$('reviewStatusMessage').update("Aguarde Salvando Resenha.");
		$('sendBox').hide();
	}else {
		$('problemsVaditadion').show();
	}
};

saveReviewSuccessCallback = function(request){
	var json =  request.responseText.evalJSON();
	requestStatusOk = json.responseParameters.requestStatusOk;
	requestStatusError = json.responseParameters.requestStatusError;
	requestStatus = json.responseParameters.requestStatus;
	if(requestStatusOk != null && requestStatus == requestStatusOk) {
		
		$('newReviewSuccess').show();
	    $('newReviewDiv').hide();
		if (document.getElementById('isLightWindow').value == 'true'){
			$('statusBox').show();
		}
	}else{
		saveReviewFailedCallback(request);
	}
};
	
saveReviewFailedCallback = function(request){
	$('reviewStatusMessage').update("Erro ao salvar resenha.");
	if (document.getElementById('isLightWindow').value == 'true'){
		$('statusBox').show();
	}
};