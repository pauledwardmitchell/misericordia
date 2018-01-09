class Validator < ActiveModel::Validator

  def validate(record)
    unless record.email.ends_with? ENV['USER_EMAIL']
      record.errors[:email] << 'Please contact site administrator.'
    end
  end

end
