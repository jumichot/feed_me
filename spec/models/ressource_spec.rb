require 'spec_helper'

describe Ressource do
  it { should validate_uniqueness_of(:resolved_id)}
  it { should validate_uniqueness_of(:resolved_url)}

  it "has a tag list" do
    ressource = create(:ressource)
    ressource.tag_list.add("ruby")
    ressource.tag_list.add("python")
    expect(ressource.tag_list).to eq ["ruby","python"]
  end
end
