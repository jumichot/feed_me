describe Pocket::Ressource do
  it "initiatize instances variables from hash" do
    ressource = Pocket::Ressource.new({toto: "tata"})
    expect(ressource.toto).to eq "tata"
  end
end
