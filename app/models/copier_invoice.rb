class CopierInvoice < ApplicationRecord
  belongs_to :copier_contract

  def current?
    if self.date.year == Date.today.year
      true
    else
      false
    end
  end

end
