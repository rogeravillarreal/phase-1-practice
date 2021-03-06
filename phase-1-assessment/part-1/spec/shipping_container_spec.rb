require_relative '../shipping_container'
require_relative '../crate'

RSpec.describe ShippingContainer do
  let(:crates) { [Crate.new(weight: 300), Crate.new({weight: 100})] }
  let(:shipping_container) { ShippingContainer.new({destination: 'Hawaii', crates: crates, max_weight: 500, max_crates: 10}) }

  describe 'attributes' do
    it 'has a destination' do
      expect(shipping_container.destination).to eq 'Hawaii'
    end

    it 'has a max_weight' do
      expect(shipping_container.max_weight).to eq 500
    end

    it 'allows updates to max_weight' do
      shipping_container.max_weight = 800
      expect(shipping_container.max_weight).to eq 800
    end

    it 'has a max_crates' do
      expect(shipping_container.max_crates).to eq 10
    end

    it 'has crates' do
      expect(shipping_container.crates).to match_array crates
    end
  end

  describe 'working with crates', { pending: false } do
    describe '#current_weight' do
      context 'when empty' do
        let(:shipping_container) { ShippingContainer.new({destination: 'Hawaii', crates: [], max_crates: 10, max_weight: 500})}
        it 'returns 0' do
          expect(shipping_container.current_weight).to be 0
        end
      end

      context 'when one or more crates has been loaded' do
        it 'returns the total weight of the crates' do
          expect(shipping_container.current_weight).to eq 400
        end
      end
    end

    describe '#crates_count' do
      it 'returns the number of crates currently loaded' do
        expect(shipping_container.crates_count).to eq 2
      end
    end

    describe '#add_crate' do
      let(:crate) { Crate.new({weight: 50}) }
      context 'when within max weight and max crates' do
        it 'returns true' do
          expect(shipping_container.add_crate(crate)).to be true
        end

        it 'adds crate to shipping container' do
          shipping_container.add_crate(crate)
          expect(shipping_container.crates).to include(crate)
        end
      end

      context 'when exceeding max weight' do
        let(:shipping_container) { ShippingContainer.new({destination: 'Hawaii', crates: crates, max_weight: 425, max_crates: 10})}
        it 'returns false' do
          expect(shipping_container.add_crate(crate)).to be false
        end
      end

      context 'when exceeding max crates' do
        let(:shipping_container) { ShippingContainer.new({destination: 'Hawaii', crates: crates, max_weight: 500, max_crates: 2})}
        it 'returns false' do
          expect(shipping_container.add_crate(crate)).to be false
        end

        it 'does not add crate to the shipping container' do
          shipping_container.add_crate(crate)
          expect(shipping_container.crates).not_to include(crate)
        end
      end
    end
  end
end
