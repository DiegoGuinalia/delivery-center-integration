# frozen_string_literal: true

module Support
  # halt for set response to return http request
  class ApiResponse
    def initialize(route)
      @r = route
    end

    def params
      JSON.parse(@r.body.read).symbolize_keys!
    end

    def success(msg)
      @r.halt 200, { message: msg }
    end

    def created(msg)
      @r.halt 201, { message: msg }
    end

    def accepted(msg)
      @r.halt 202, { message: msg }
    end

    def failure(msg)
      @r.halt 202, { error: msg }
    end

    def no_content
      @r.halt 204
    end

    def non_authoritative_information
      @r.halt 203, { message: 'Non Authoritative Information' }
    end

    def unauthorized_user
      @r.halt 401, { message: 'Unauthorized User' }
    end

    def found
      @r.halt 302, { message: 'found' }
    end

    def unprocessable_entity
      @r.halt 422, { message: 'Unprocessable Entity' }
    end

    def not_found
      @r.halt 404, { message: 'Not Found' }
    end

    def locked
      @r.halt 423, { message: 'Locked' }
    end
    
    def token
      @r.headers['token']
    end
  end
end