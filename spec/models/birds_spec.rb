require 'rails_helper'

RSpec.describe Birds, type: :model do
  context "model validations" do
    it "checks bird creation with missing values fails" do
      bird = Birds.new()
      expect(bird.save).to eq(false)
    end

    it "Creates a bird without the visible params" do
      name = Faker.name
      family = Faker.name
      continents = [Faker.name]
      added_at = Date.today
      bird = Birds.create({name: name, family: family, continents: continents, added_at: added_at})
      expect(Birds.find_by({ name: name }).visible).to eq(false)
    end
  end
end
