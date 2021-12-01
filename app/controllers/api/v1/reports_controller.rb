class Api::V1::ReportsController < ApplicationController
  # before_action :authenticate_request!
  before_action :find_wallet

  def index
    @file_name = report_params[:name]
    @report_title = "Wallet #{@wallet.name} - report for #{report_params[:year]}/#{report_params[:month]}"
    @transactions = @wallet.transactions
        .where(date: DateTime.new(report_params[:year].to_i, report_params[:month].to_i, 1)..DateTime.civil(report_params[:year].to_i, report_params[:month].to_i, -1))
        .order(date: :desc)
    @income_transactions= []
    @income_total = 0
    @expense_transactions = []
    @expense_total = 0
    @other_transactions = []
    @debt_total = 0
    @loan_total = 0
    @other_total = 0
    @transactions.each do |transaction|
      case transaction.category[:main_type]
      when Category::main_types[:INCOME]
        @income_total += transaction.amount
        @income_transactions.push(transaction)
      when Category::main_types[:EXPENSE]
        @expense_transactions.push(transaction)
        @expense_total += transaction.amount
      when Category::main_types[:DEBT]
        @other_transactions.push(transaction)
        @debt_total += transaction.amount
      when Category::main_types[:LOAN]
        @other_transactions.push(transaction)
        @loan_total -= transaction.amount
      when Category::main_types[:RECOVER_LOAN]
        @other_transactions.push(transaction)
        @other_total += transaction.amount
      when Category::main_types[:BACK_DEBT]
        @other_transactions.push(transaction)
        @other_total -= transaction.amount
      end
    end
  end

  private

  def find_wallet
    @wallet = Wallet.find(params[:wallet_id])

    render_error :not_found, "Wallet ##{params[:wallet_id]} not found" unless @wallet
  end

  def report_params
    params.permit([:year, :month, :name])
  end
end