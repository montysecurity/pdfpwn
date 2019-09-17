#pdfpwn

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
- Your *c2.txt* can be named anything (tested with txt files) but changing the name of the file containing C2 commands or where it is in the directory structure will render any existing C2 connections *inoperable* until either the change is reverted or the setup script is re-run with the updated URL
- To parse commands, it works by file hash so you can edit the file names in the setup script to your liking

HOW IT WORKS:
- After running the setup script, a *parser* is created in the working directory
- This parser is responsible for contacting the URL you gave it, and downloading the commands via wget
- It then does a name change to override the old C2 commands
- Then it creates a blank PDF file in the working directory
- Next, it encodes the newly downloaded C2 commands and sets the output as a environment variable (in the context of the script so running env does not provide any insight into the script)
- Then it replaces the value of metadata on a particular line in the PDF file with the encoded commands
- Next, it calculates the MD5 hash of the PDF file containing the C2 commands and sets the value as a environment variable (also in the context of the script)
- Finally it executes *find* to, well, find, the file containing the correct hash, parses the commands, decodes them, and pipes to shell
- By default, this plays out every minute. To change this, edit the cron time at the bottom of the script. If no commands need to be executed for some time, consider changing the c2 file to something like "export TERM=xterm" or "tmp=temp && unset tmp" (or just deleting the c2 file, that will notraise any errors on the target)
