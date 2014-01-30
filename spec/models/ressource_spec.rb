require 'spec_helper'

describe Ressource do
  it { should validate_uniqueness_of(:resolved_id)}
  it { should validate_uniqueness_of(:resolved_url)}
end
