require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def spec(argv=ARGV)
    RSpec::Core::Runner.disable_autorun!
    exit RSpec::Core::Runner.run(argv)
  end
end

Zeus.plan = CustomPlan.new
