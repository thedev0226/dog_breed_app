class DogsController < ApplicationController
  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)

    if @dog.save
      result = DogApiService.fetch_breed_image(@dog.breed_name)

      if result.success
        # Respond with TurboStreams to update the UI
        render turbo_stream: turbo_stream.replace('dog_image', partial: 'dogs/image', locals: { breed_image: result.data })
      else
        @dog.errors.add(:breed_name, result.error_message)
        render turbo_stream: turbo_stream.replace('dog_image', partial: 'dogs/error_messages', locals: { errors: @dog.errors })
      end
    else
      # Handle validation errors
      render :new
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:breed_name)
  end
end
