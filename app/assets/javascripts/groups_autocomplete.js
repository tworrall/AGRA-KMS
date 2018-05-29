var setupGroupsAutoComplete = {
    onLoad: function() {
		if ( $('body').prop('className').indexOf("collection") >= 0 ) {
			console.log($('body').prop('className'));
		}
		this.initGroupsAutocomplete();
	},
		
	initGroupsAutocomplete: function() {
		$('input#permission_template_access_grants_attributes_0_agent_id').autocomplete({
    			source: the_groups,
        		minLength: 2
		})
		$('input#collection_type_participant_agent_id').autocomplete({
    			source: the_groups,
        		minLength: 2
		})
	}
		
};

Blacklight.onLoad( function() {
    if ( $('body').prop('className').indexOf("collections_edit") >= 0 ||
         $('body').prop('className').indexOf("collection_types_edit") >= 0 ||
         $('body').prop('className').indexOf("admin_sets_edit") >= 0 ) {

			setupGroupsAutoComplete.onLoad();

    }
});
