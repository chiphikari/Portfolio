FactoryBot.define do
  factory :post_image do
    image { [ Rack::Test::UploadedFile.new(Rails.root.join( 'app/assets/images/noimage.jpg'), 'app/assets/images/noimage.jpg')  ]}
  end
end