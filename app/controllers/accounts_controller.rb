class AccountsController < ApplicationController
  def deposit
    account = Account.find_by(account_number: params[:account_number])
    if account
      account.balance += params[:amount].to_d
      if account.save
        render json: { message: 'Deposit successful', balance: account.balance }, status: :ok
      else
        render json: { errors: account.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Account not found' }, status: :not_found
    end
  end

  def withdraw
    account = Account.find_by(account_number: params[:account_number])
    if account
      if account.balance >= params[:amount].to_d
        account.balance -= params[:amount].to_d
        if account.save
          render json: { message: 'Withdrawal successful', balance: account.balance }, status: :ok
        else
          render json: { errors: account.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Insufficient balance' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Account not found' }, status: :not_found
    end
  end
end
