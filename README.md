# Users API

## Endpoints

### POST /users/register

Registers a new user with 2000.00 beginning balance

**Request Body:**

```json
{
  "full_name": "example",
  "username": "example",
  "password": "password123",
  "email": "example@example.com"
}
```

### GET /users

Retrieves all users along with their associated accounts.

# Accounts API

## Endpoints

### POST /accounts/deposit

Deposits an amount into a specified account.

**Request Body:**

```json
{
  "account_number": "12345678-1",
  "amount": 1000.0
}
```

### POST /accounts/withdraw

Withdraws an amount from a specified account.

**Request Body:**

```json
{
  "account_number": "12345678-1",
  "amount": 1000.0
}
```

### POST /accounts/transfer

Transfers an amount from one account to another.

**Request Body:**

```json
{
  "from_account_number": "12345678-1",
  "to_account_number": "12345678-2",
  "amount": 1000.0
}
```

### GET /accounts/:id

Retrieves the balance, bank number, and bank type of a specified account.

**Path Parameters:**
`id`: The ID of the account.
