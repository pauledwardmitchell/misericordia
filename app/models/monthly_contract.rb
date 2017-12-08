class MonthlyContract < ApplicationRecord
  include ReportCalc
  include ReportCalcMonthly
end
