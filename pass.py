import hashlib

def main():
  print("***** dGree CNP encryption solution *****\n")
  print("Enter student's CNP: ", end="")
  cnp = input()
  print()
  print("Enter student's password: ", end="")
  password = input()
  print()

  secret = cnp + "-" + password
  hash_secret = "\"0x" + hashlib.sha256(secret.encode()).hexdigest() + "\""
  print("HASH :", hash_secret)

  print("\nUse HASH to interact with the smart contract (quotation marks included)")

main()