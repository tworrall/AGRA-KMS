module API
  module V1
    class GenericWorksController < BaseController
      # before_action :authenticate
      protect_from_forgery with: :null_session

      def initialize
        @fq = "has_model_ssim:GenericWork"
        @max_rows = ActiveFedora::SolrService::MAX_ROWS
        @fl = ['id', 'title_tesim', 'depositor_ssim', 'commodities_tesim',
          'keywords_tesim', 'language_tesim', 'resource_type_tesim',
          'subject_tesim', 'description_tesim', 'based_near_tesim', 'member_of_collections_ssim',
          'visibility_ssi', 'date_uploaded_dtsi', 'date_modified_dtsi']
        @df = ['title_tesim', 'commodities_tesim', 'keywords_tesim', 'based_near_tesim']

      end
      
      def findAll
        query = "*:*"
        works = ActiveFedora::SolrService.query(query, fq: @fq, fl: @fl, rows: @max_rows)
        format_solr_keys(works)
        render(json: works)
      end
      
      # TODO: This should search all fields, currently default search field set to description
      def search
        query = params[:q]
        works = ActiveFedora::SolrService.query(query, fq: @fq, fl: @fl, df: @df, rows: @max_rows) 
        format_solr_keys(works)
        render(json: works)
      end
      
    end
  end
end
