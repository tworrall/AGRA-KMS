module API
  module V1
    class BaseController < ApplicationController
      # before_action :destroy_session

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveFedora::RecordInvalid, with: :record_invalid
      # rescue_from Rack::QueryParser::InvalidParameterError, with: :bad_request
      rescue_from ArgumentError, with: :argument_error
      rescue_from StandardError, with: :standard_error

      @user = nil

      def destroy_session
        request.session_options[:skip] = true
      end

      # Removes all the solr suffixes (tesim)
      # TODO Should we check for actual suffixes instead of checking for an underscore in the key
      def format_solr_keys(docs)
        docs.each do |doc|
          doc.keys.each do |k|
            if k.include? '_'
              doc[k.rpartition('_').first] = doc[k]
              doc.delete(k)
            end
          end
        end
      end

      protected

        def authenticate
          authenticate_token || render_unauthorized
        end

        def authenticate_token
          authenticate_with_http_token do |token, _options|
            @user = User.where(auth_token: token).first
          end
        end

        def render_unauthorized
          headers['WWW-Authenticate'] = 'Token realm="Application"'
          render json: 'Bad credentials', status: 401
        end

      private

        def solr_connection
          ActiveFedora::SolrService.instance.conn
        end

        def bad_request(error)
          render json: { error: error.message }, status: 400
        end

        def record_not_found(error)
          render json: { error: error.message }, status: 404
        end

        def record_invalid(error)
          render json: { error: error.message }, status: 500
        end

        def argument_error(error)
          render json: { error: error.message }, status: 500
        end

        def standard_error(error)
          render json: { error: error.message }, status: 500
        end

        def unauthorized
          render json: { error: "Unauthorized" }, status: 401
        end
    end
  end
end
