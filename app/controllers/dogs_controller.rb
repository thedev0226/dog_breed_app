class DogsController < ApplicationController
  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)

    @dog.save
  end

  private

  def dog_params
    params.require(:dog).permit(:breed_name)
  end
end
