class SearchesController < ApplicationController
    before_action :authenticate_user!

    def index
        @searches = current_user.searches
    end
end
