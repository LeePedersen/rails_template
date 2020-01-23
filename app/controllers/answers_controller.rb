
class AnswersController < ApplicationController


  before_action :authorize, only: [:new, :create, :edit]
  before_action :authorize_admin, only: [:destroy]

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new
    render :new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    render :show
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    render :edit
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question)
    else
      render :edit
    end
  end


  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(@answer.question)
  end


  private
  def answer_params
    params.require(:answer).permit(:body, :user_name, :question_id)
  end

end
