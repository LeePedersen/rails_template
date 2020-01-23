# NEED TO CHANGE ACCORDING TO PROJECT PARAMETERS
#

class QuestionsController < ApplicationController

  before_action :authorize, only: [:new, :create, :edit]
  before_action :authorize_admin, only: [:destroy]

  def index
    @questions = Question.all
    render :index
  end

  def new
    @question = Question.new
    @user = User.find(session[:user_id])
    @user_name = @user.email
    render :new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "You have saved your question"
      redirect_to questions_path
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
    render :edit
  end

  def show
    @question = Question.find(params[:id])
    render :show
  end

  def update
    @question= Question.find(params[:id])
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :body, :user_name)
  end

end
