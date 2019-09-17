#PDFPWN

AUTHOR: monty

PURPOSE: Provide Red Team Operators and Pentesters a way to "passively" run a C2 campaign with minimal tools and interaction

FILES:
- README.md - ...
- setup.sh - the magic shell file

REQUIREMENTS:
- Your own C2 server to host the files containing C2 commands (tested with webservers)
- The target must be able to access the C2 server
- C2 server must contain a public facing text file containing shell commands to be executed on the target

USAGE:
- Upload setup.sh to target
- Run setup.sh (chmod +x setup.sh && ./setup.sh) and provide the full URL to the file containing the C2 commands (e.g. http://fqdn.domain.top/c2.txt)
- Administer the target box remotely by changing the contents of "c2.txt"

NOTES:
- Changing the name of the file containing C2 commands or where it is in the directory structure will render any existing C2 connections *inoperable* until either
-- The change is reverted or
-- The setup script is re-run with the updated URL
