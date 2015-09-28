require 'conway/life'

RSpec.describe Conway::Life do
  it '#new works' do
    described_class.new([[1, 0, 1], [0, 0, 0], [1, 0, 1]])
  end
end
