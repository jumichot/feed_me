require 'spec_helper'

describe Topic do
  it { should validate_uniqueness_of(:name)}
  it { should have_many(:ressources)}
end
