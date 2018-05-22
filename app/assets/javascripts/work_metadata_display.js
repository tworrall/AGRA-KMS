var manageWorkMetadata = {
    onLoad: function() {
		this.delayTheSetEventCall();
		this.setInitialLanguageAutocomplete();
	},
	
	delayTheSetEventCall: function() {
		setTimeout(function() {
			manageWorkMetadata.setEventOnAddButton("all")
		}, 500);
	},
	
	setEventOnAddButton: function(target) {
		$('button.add').each(function() {
			if ( target == "based_near" || target == "all" ) {
				if ( $(this).closest('div').attr('class').indexOf('generic_work_based_near') >= 0 ) {
					$(this).click(function() {
						setTimeout(manageWorkMetadata.initLanguageAutocomplete,500);
					})
				}
			}
		})
	},
	
	initLanguageAutocomplete: function() {
		$('input.generic_work_based_near').each(function() {
			$(this).autocomplete({
        		minLength: 3,
        		source: function(request, response) {
            		$.ajax({
                		url: '/authorities/search/local/geo_locations?q=' + request.term,
						type: 'GET',
                		dataType: 'json',
                		complete: function(xhr, status) {
                    		var results = $.parseJSON(xhr.responseText);                        
                    		response(results);
                		}
            		});
        		}
			})
    	})
		manageWorkMetadata.setEventOnAddButton("based_near");
	},
		
	setInitialLanguageAutocomplete: function() {
		$('input.generic_work_based_near').each(function() {
			$(this).autocomplete({
	        	minLength: 3,
	        	source: function(request, response) {
	            	$.ajax({
	                	url: '/authorities/search/local/geo_locations?q=' + request.term,
						type: 'GET',
	                	dataType: 'json',
	                	complete: function(xhr, status) {
	                    	var results = $.parseJSON(xhr.responseText);                        
	                    	response(results);
	                	}
	            	});
	        	}
		    })
	    })
	}

};

Blacklight.onLoad( function() {
    $('body.generic_works_new').each(function() {
		manageWorkMetadata.onLoad();
    })
    $('body.generic_works_edit').each(function() {
		manageWorkMetadata.onLoad();
    })
});
