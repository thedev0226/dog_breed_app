class DogApiService
  BASE_URL = 'https://dog.ceo/api'

  Result = Struct.new(:success, :data, :error_message)

  def self.fetch_breed_image(breed_name)
    response = Faraday.get("#{BASE_URL}/breed/#{breed_name}/images/random")
    json = JSON.parse(response.body)

    if response.success? && json['status'] == 'success'
      Result.new(true, json['message'], nil)
    else
      Result.new(false, nil, "Breed not found: #{breed_name}. Possible breeds: #{fetch_available_breeds.data&.join(', ')}")
    end
  rescue Faraday::Error => e
    Result.new(false, nil, "Error connecting to Dog API: #{e.message}")
  end

  def self.fetch_available_breeds
    response = Faraday.get("#{BASE_URL}/breeds/list/all")
    json = JSON.parse(response.body)

    if response.success? && json['message'].is_a?(Hash)
      Result.new(true, json['message'].keys, nil)
    else
      Result.new(false, nil, "Error connecting to Dog API")
    end
  rescue Faraday::Error => e
    Result.new(false, nil, "Error connecting to Dog API: #{e.message}")
  end
end
