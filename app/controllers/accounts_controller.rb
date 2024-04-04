class AccountsController < ApplicationController
  def show
    account = Account.find_by(id: params[:id])
    if account
      render json: { balance: account.balance, account_number: account.account_number, account_type: account.account_type }, status: :ok
    else
      render json: { error: 'Account not found' }, status: :not_found
    end
  end

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

  def transfer
    from_account = Account.find_by(account_number: params[:from_account_number])
    to_account = Account.find_by(account_number: params[:to_account_number])

    if from_account && to_account
      if from_account.balance >= params[:amount].to_d
        from_account.balance -= params[:amount].to_d
        to_account.balance += params[:amount].to_d

        Account.transaction do
          if from_account.save && to_account.save
            render json: { message: 'Transfer successful', from_account_balance: from_account.balance, to_account_balance: to_account.balance }, status: :ok
          else
            render json: { errors: from_account.errors.full_messages + to_account.errors.full_messages }, status: :unprocessable_entity
          end
        end
      else
        render json: { error: 'Insufficient balance' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Account not found' }, status: :not_found
    end
  end
end
