require 'spec_helper'

describe Topic do
  it { should validate_uniqueness_of(:name)}
end
