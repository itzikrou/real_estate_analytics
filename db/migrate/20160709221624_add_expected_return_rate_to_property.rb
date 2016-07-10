class AddExpectedReturnRateToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :expected_return_rate, :float
  end
end
