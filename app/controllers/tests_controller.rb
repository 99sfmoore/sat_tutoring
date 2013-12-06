class TestsController < ApplicationController
  def new
    @test = Test.new
  end

  def create 
    @test = Test.new(test_params)
    @test.load_questions_from_file(params[:test][:question_file])
    @test.set_conversion(params[:test][:conversion])
    if @test.save
      redirect_to @test
    else
      render 'new'
    end
  end

  def show
    @test = Test.find(params[:id])
  end

  def delete
  end





  private
    def test_params
      params.require(:test).permit(:name)
    end
end
