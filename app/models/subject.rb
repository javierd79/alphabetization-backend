class Subject < ApplicationRecord
  belongs_to :company

  def self.available
    subjects = Subject.select { |item| item.max_students <= item.students_subscribed.length }
    return subjects
  end

  def reports
    self.students_subscribed.map do |item|
      User.find(item)
    end
  end
end
