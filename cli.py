import argparse
import sys
from pyspin.version import __version__
from pyspin.core.init_project import init_project

def main():
    parser = argparse.ArgumentParser(prog="pyspin", description="Create Dockerfile and compose.yml file to start coding in python.")
    subparsers = parser.add_subparsers(dest="command")

    parser_init = subparsers.add_parser("init", help="Créer un Dockerfile et docker-compose.yml par défaut")

    parser.add_argument("--version", action="store_true", help="Afficher la version")

    args = parser.parse_args()

    if args.version:
        print(f"pyspin {__version__}")
        sys.exit(0)

    if args.command == "init":
        init_project()
    else:
        parser.print_help()
