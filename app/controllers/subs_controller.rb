class SubsController < ApplicationController

  before_action :require_moderator, only: [:edit, :update]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(subs_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(subs_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :show
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def require_moderator
    @sub = Sub.find(params[:id])
    if current_user.username == @sub.moderator.username
    else
      flash[:errors] = ["You do not have authorization"]
      render :show
    end
  end



  def subs_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
end
