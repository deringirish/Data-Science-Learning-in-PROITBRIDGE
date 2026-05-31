# chapter 6 - Task 1 - OOPs - Inheritance, Encapsulation, Polymorphism, Abstraction


from abc import ABC, abstractmethod
import random


class Tranasction(ABC):
    @abstractmethod
    def deposit(self, amount):
        pass

    @abstractmethod
    def withdraw(self, amount):
        pass


class Account(Tranasction):

    used_accounts = set()
    used_cards = set()
    used_username = set()

    def __init__(self, name, username, password, balance):
        self.name = name
        self.username = username
        self.__password = password
        self.__balance = balance
        self.has_atm = False
        self.card_number = None
        self.__pin = None

        while True:
            acc = random.randint(100000, 999999)
            if acc not in Account.used_accounts:
                self.account_number = acc
                Account.used_accounts.add(acc)
                break

    def verify_password(self, password):
        return self.__password == password

    def verify_pin(self, pin):
        return self.__pin == pin

    def check_balance(self):
        print("\n-----------------------------")
        print(f"Balance: {self.__balance}")

    def apply_atm(self):

        if self.has_atm:
            print("\n-----------------------------")
            print("ATM Card already exists")
            return

        while True:
            card = random.randint(10000000, 99999999)
            if card not in Account.used_cards:
                self.card_number = card
                Account.used_cards.add(card)
                break

        print("\n-----------------------------")
        self.__pin = int(input("Create ATM PIN: "))
        self.has_atm = True
        print("\n-----------------------------")
        print("ATM Card Created")
        print(f"Card Number: {self.card_number}")
        print("Please Note down the card Number and Pin")

    def change_pin(self):
        print("\n-----------------------------")
        old_pin = int(input("Enter old PIN: "))

        if self.verify_pin(old_pin):
            self.__pin = int(input("Enter new PIN: "))
            print("\n-----------------------------")
            print("New Pin Set Successfully")
        else:
            print("\n-----------------------------")
            print("Wrong PIN")

    def deposit(self, amount):
        self.__balance += amount
        print("\n-----------------------------")
        print("Deposit Successfully")

    def withdraw(self, amount):
        if amount <= self.__balance:
            self.__balance -= amount
            print("\n-----------------------------")
            print("Withdraw Successfully")
        else:
            print("\n-----------------------------")
            print("Insufficient Balance")


accounts = {}

while True:
    print("\n-----------------------------")
    print("1. Bank \n2. ATM \n3. Exit")
    system = int(input("Choose: "))

    if system == 1:
        print("\n-----------------------------")
        print("1. Create Account \n2. Login \n3. Back")
        choice = int(input("Choose: "))

        if choice == 1:
            print("\n-----------------------------")
            name = input("Name: ")
            while True:
                user_name = input("Username: ")

                if user_name not in Account.used_username:
                    break
                else:
                    print("\n-----------------------------")
                    print("Username already exists. Choose another Username")

            password = input("Password: ")
            while True:
                deposit = int(input("Initial Deposit: "))

                if deposit <= 0:
                    print("\n-----------------------------")
                    print("Initial Deposit should need to more that 1")
                else:
                    break

            acc = Account(name, user_name, password, deposit)
            accounts[user_name] = acc
            Account.used_username.add(user_name)
            print("\n-----------------------------")
            print("Account Created")
            print(f"Account Number: {acc.account_number}")

        elif choice == 2:
            print("\n-----------------------------")
            user_name = input("Username: ")

            if user_name in accounts:
                password = input("Password: ")

                if accounts[user_name].verify_password(password):
                    user = accounts[user_name]
                    while True:
                        print("\n-----------------------------")
                        print(
                            "1. Deposit \n2. Withdraw \n3. Balance \n4. Apply Atm \n5. Logout"
                        )
                        option = int(input("Choose: "))

                        if option == 1:
                            print("\n-----------------------------")
                            amount = int(input("Amount: "))
                            if amount > 0:
                                user.deposit(amount)
                            else:
                                print("\n-----------------------------")
                                print("Invalid Amount")

                        elif option == 2:
                            print("\n-----------------------------")
                            amount = int(input("Amount: "))
                            if amount > 0:
                                user.withdraw(amount)
                            else:
                                print("\n-----------------------------")
                                print("Invalid Amount")

                        elif option == 3:
                            user.check_balance()

                        elif option == 4:
                            user.apply_atm()

                        elif option == 5:
                            break

                else:
                    print("\n-----------------------------")
                    print("Wrong Password")

            else:
                print("\n-----------------------------")
                print("Account not Found")

        elif choice == 3:
            continue

    elif system == 2:
        print("\n-----------------------------")
        card = int(input("Card Number: "))
        pin = int(input("Pin: "))
        account_found = None

        for user in accounts.values():
            if user.card_number == card and user.verify_pin(pin):
                account_found = user
                break

        if account_found:
            while True:
                print("\n-----------------------------")
                print("1. Deposit \n2. Withdraw \n3. Balance \n4. Change PIN \n5. Exit")
                option = int(input("Choose: "))
                if option == 1:
                    print("\n-----------------------------")
                    amount = int(input("Amount : "))
                    if amount > 0:
                        account_found.deposit(amount)
                    else:
                        print("\n-----------------------------")
                        print("Invalid Amount")
                elif option == 2:
                    print("\n-----------------------------")
                    amount = int(input("Amount: "))
                    if amount > 0:
                        account_found.withdraw(amount)
                    else:
                        print("\n-----------------------------")
                        print("Invalid Amount")
                elif option == 3:
                    account_found.check_balance()
                elif option == 4:
                    account_found.change_pin()
                elif option == 5:
                    break

        else:
            print("\n-----------------------------")
            print("Invalid Card or PIN")

    elif system == 3:
        print("\n-----------------------------")
        print("Thank You")
        break
