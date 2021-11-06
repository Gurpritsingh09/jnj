from datetime import datetime
from datetime import timedelta
import argparse
import sys
from subprocess import PIPE, Popen

def setSASToken(container, account):
    startDate = datetime.now()
    endDate = startDate + timedelta(days=183)

    permissions = "rwlac"
    command = """az storage container generate-sas \
        --name {} \
        --account-name {} \
        --expiry {} \
        --permissions {}
    """.format(
        container,
        account,
        endDate.strftime("%Y-%m-%d"),
        permissions
    )

    process = Popen(
        args=command,
        stdout=PIPE,
        shell=True
    )
    return process.communicate()[0].decode()

def storeToken(token, secretName="redox-sas-token-qa", vaultName="EUN-DS-QA-VLT-hsdi"):
    command = """az keyvault secret set \
        --name {} \
        --vault-name {} \
        --value {}
    """.format(
        secretName,
        vaultName,
        token
    )

    process = Popen(
        args=command,
        stdout=PIPE,
        shell=True
    )
    return process.communicate()[0].decode()

def main(argv):
    parser = argparse.ArgumentParser()

    parser.add_argument("--container", "-c", help="Container to grant access to", metavar='container', required=True)
    parser.add_argument("--account", "-a", help="Storage Account name", metavar='account', required=True)

    args = parser.parse_args()

    token = setSASToken(args.container, args.account)
    storeToken(token, "redox-sas-token-qa", "EUN-DS-QA-VLT-hsdi")

    print("SAS Token (initial) for Redox container :: {}".format(token))

if __name__ == "__main__":
   main(sys.argv[1:])
