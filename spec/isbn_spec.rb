# frozen_string_literal: true

require 'isbn'

describe 'ISBN' do
  context 'when valid input' do
    subject { ISBN::ISBN.new('978014300723') }

    describe '#isbn' do
      it 'return correct full-length code' do
        expect(subject.isbn).to eq('9780143007234')
      end
    end

    describe '#check_digit' do
      it 'return correct check digit' do
        expect(subject.check_digit).to eq(4)
      end
    end
  end

  context 'when invalid input' do
    context 'when too short input' do
      it 'expect raise InvalidSourceStringError' do
        expect { ISBN::ISBN.new('978') }.to raise_error(ISBN::InvalidSourceStringError)
      end
    end

    context 'when too long input' do
      it 'expect raise InvalidSourceStringError' do
        expect do
          ISBN::ISBN.new('97887923983828947828348923984')
        end.to raise_error(ISBN::InvalidSourceStringError)
      end
    end

    context 'when input with letters' do
      it 'expect raise InvalidSourceStringError' do
        expect { ISBN::ISBN.new('DH8014300723') }.to raise_error(ISBN::InvalidSourceStringError)
      end
    end
  end
end
