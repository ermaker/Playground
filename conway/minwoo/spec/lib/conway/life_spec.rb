require 'conway/life'

RSpec.describe Conway::Life do
  it '#new works' do
    described_class.new([[1, 0, 1], [0, 0, 0], [1, 0, 1]])
  end

  describe 'with basic case' do
    subject do
      described_class.new([[1, 0, 1], [0, 0, 0], [1, 0, 1]])
    end

    it '#normalize works' do
      expect(subject.normalize(0, 0)).to eq([0, 0])
      expect(subject.normalize(3, 3)).to eq([0, 0])
    end

    it '#neighbours works' do
      expect(subject.neighbours(1, 1)).to eq([1, 0, 1, 0, 0, 1, 0, 1])
    end

    it '#sum works' do
      expect(subject.sum(1, 1)).to eq(4)
    end

    it '#next_value works' do
      allow(subject).to receive(:value).with(1, 1).and_return(0)
      expect(subject).to receive(:sum).with(1, 1).and_return(3)
      expect(subject.next_value(1, 1)).to eq(1)
      expect(subject).to receive(:sum).with(1, 1).and_return(2)
      expect(subject.next_value(1, 1)).to eq(0)

      allow(subject).to receive(:value).with(1, 1).and_return(1)
      expect(subject).to receive(:sum).with(1, 1).and_return(3)
      expect(subject.next_value(1, 1)).to eq(1)
      expect(subject).to receive(:sum).with(1, 1).and_return(2)
      expect(subject.next_value(1, 1)).to eq(1)
      expect(subject).to receive(:sum).with(1, 1).and_return(1)
      expect(subject.next_value(1, 1)).to eq(0)
    end

    it '#next_generation works' do
      expect(subject.next_generation).to eq([[1, 0, 1], [0, 0, 0], [1, 0, 1]])
    end
  end

  it '#next_generation works' do
    # zero
    sub = described_class.new([[1, 0, 1], [0, 0, 0], [1, 0, 1]])
    expect(sub.next_generation).to eq([[1, 0, 1], [0, 0, 0], [1, 0, 1]])

    # case 1
    sub = described_class.new([[1, 0, 1], [0, 0, 1], [1, 0, 0]])
    expect(sub.next_generation).to eq([[1, 0, 1], [0, 0, 1], [1, 0, 0]])

    # rubocop:disable Metrics/LineLength

    # case 2
    sub = described_class.new(
      [[1, 0, 0, 1, 1], [0, 1, 0, 0, 0], [1, 0, 1, 1, 0], [0, 0, 0, 1, 0], [0, 1, 1, 1, 0]]
    )
    expect(sub.next_generation).to eq(
      [[1, 0, 0, 1, 1], [0, 1, 0, 0, 0], [0, 1, 1, 1, 1], [0, 0, 0, 0, 0], [1, 1, 0, 0, 0]]
    )
    sub = described_class.new(
      [[1, 0, 0, 1, 1], [0, 1, 0, 0, 0], [0, 1, 1, 1, 1], [0, 0, 0, 0, 0], [1, 1, 0, 0, 0]]
    )
    expect(sub.next_generation).to eq(
      [[0, 0, 1, 0, 1], [0, 1, 0, 0, 0], [1, 1, 1, 1, 0], [0, 0, 0, 1, 1], [1, 1, 0, 0, 0]]
    )
    sub = described_class.new(
      [[0, 0, 1, 0, 1], [0, 1, 0, 0, 0], [1, 1, 1, 1, 0], [0, 0, 0, 1, 1], [1, 1, 0, 0, 0]]
    )
    expect(sub.next_generation).to eq(
      [[0, 0, 1, 0, 0], [0, 0, 0, 0, 1], [1, 1, 0, 1, 0], [0, 0, 0, 1, 0], [1, 1, 1, 0, 0]]
    )
    sub = described_class.new(
      [[0, 0, 1, 0, 0], [0, 0, 0, 0, 1], [1, 1, 0, 1, 0], [0, 0, 0, 1, 0], [1, 1, 1, 0, 0]]
    )
    expect(sub.next_generation).to eq(
      [[1, 0, 1, 1, 0], [1, 1, 1, 1, 1], [1, 0, 1, 1, 0], [0, 0, 0, 1, 0], [0, 1, 1, 1, 0]]
    )
    sub = described_class.new(
      [[1, 0, 1, 1, 0], [1, 1, 1, 1, 1], [1, 0, 1, 1, 0], [0, 0, 0, 1, 0], [0, 1, 1, 1, 0]]
    )
    expect(sub.next_generation).to eq(
      [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 1, 0, 0, 0]]
    )
    sub = described_class.new(
      [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 1, 0, 0, 0]]
    )
    expect(sub.next_generation).to eq(
      [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
    )
    sub = described_class.new(
      [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 1, 0, 0, 0]]
    )
    expect(sub.next_generation).to eq(
      [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
    )

    # rubocop:enable Metrics/LineLength
  end
end
