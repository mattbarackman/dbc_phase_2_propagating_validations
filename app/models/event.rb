class CustomDateValidation < ActiveModel::Validator
  def validate(record)
    if record.date.nil? || record.date.to_s.empty?
      record.errors[:date] << "can't be blank or invalid"
    elsif record.date < Time.now()
      record.errors[:date] << 'must be in the future'
    end
  end
end

class Event < ActiveRecord::Base

  validates :organizer_name, :presence => true
  validates :organizer_email, :presence => true,
                              :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  validates :title, :presence => true

  validates_with CustomDateValidation

end
