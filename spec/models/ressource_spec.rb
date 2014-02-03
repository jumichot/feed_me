require 'spec_helper'

describe Ressource do
  it { should validate_uniqueness_of(:resolved_id)}
  it { should validate_uniqueness_of(:resolved_url)}
  it { should validate_presence_of(:resolved_id)}
  it { should validate_presence_of(:resolved_url)}

  it "has a tag list" do
    ressource = create(:ressource)
    ressource.tag_list.add("ruby")
    ressource.tag_list.add("python")
    expect(ressource.tag_list).to eq ["ruby","python"]
  end

  it "can retrieve ressource by tags" do
    r1 = create_ressource_with_tag ["ruby","lol"]
    r2 = create_ressource_with_tag ["lol"]
    expect(Ressource.tagged_with("lol")).to eq [r1, r2]
  end

  def create_ressource_with_tag ary
    ressource = create(:ressource)
    ary.each { |tag| ressource.tag_list.add(tag) } 
    ressource.save
    ressource
  end
end
