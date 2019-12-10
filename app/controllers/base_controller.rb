class BaseController < ApplicationController
    def index
        @locations = Location.all
        @areas = Area.all
    end
end
