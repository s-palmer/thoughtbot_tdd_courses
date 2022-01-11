class Person
  def initialize(first_name:, last_name:, middle_name: nil)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
    @names = []
  end

  def full_name
    [@first_name, @middle_name, @last_name].reject(&:nil?).join(' ')
  end

  def full_name_with_middle_initial
    return [@first_name, @last_name].reject(&:nil?).join(' ') if @middle_name === nil

    middle_initial = @middle_name.split('').first
    [@first_name, middle_initial, @last_name].reject(&:nil?).join(' ')
  end

  def initials
    [@first_name[0], @middle_name[0], @last_name[0]].reject(&:nil?).join('.')
  end
end
