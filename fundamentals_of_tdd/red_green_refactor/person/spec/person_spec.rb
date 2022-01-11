require 'person'

describe Person do
  describe '#full_name' do
    it 'concatenates first name, middle name, and last name with spaces' do
      john = Person.new(first_name: 'John', middle_name: 'Robert', last_name: 'Smith')

      expect(john.full_name).to eq('John Robert Smith')
    end

    it 'does not add extra spaces if middle name is missing' do
      james = Person.new(first_name: 'James', last_name: 'Smith')

      expect(james.full_name).to eq('James Smith')
    end
  end

  describe '#full_name_with_middle_initial'
  it 'concatenates first name, middle name, and last name with spaces and replaces the middle name with an initial' do
    john = Person.new(first_name: 'John', middle_name: 'Robert', last_name: 'Smith')

    expect(john.full_name_with_middle_initial).to eq('John R Smith')
  end

  it 'concatenates first name and last name if there is no middle name' do
    john = Person.new(first_name: 'John', last_name: 'Smith')

    expect(john.full_name_with_middle_initial).to eq('John Smith')
  end

  describe '#initials'
  it 'returns the initials of the name' do
    john = Person.new(first_name: 'John', middle_name: 'Robert', last_name: 'Smith')

    expect(john.initials).to eq('J.R.S')
  end
end
