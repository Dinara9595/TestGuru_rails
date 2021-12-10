class ChangeColumnDefaultToAnswers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :answers, :correct, from: true, to: false
  end
end
