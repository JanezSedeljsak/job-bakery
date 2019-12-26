class BaseController < ApplicationController
    before_action :authenticate_user!, except: [:index]

    def index
        if user_signed_in?
            if(current_user.company?)
                @jobs = Job.where({ user: current_user })
                render :template => "base/_company"
            else
                @locations = Location.all
                @areas = Area.all
                render :template => "base/_noncompany"
            end
        else
            @locations = Location.all
            @areas = Area.all
            render :template => "base/_noncompany"
        end
    end

    def profile
        @user = User.find(params[:id])
        p @user
        render :template => "base/_profile"
    end
end
