# pdfpwn

## purpose
Provide Red Team Operators and Pentesters a way to "passively" run a C2 campaign with minimal tools and interaction

## files
- README.md - ...
- pdfgen.sh - ran on attack box, creates payload, move payload to webserver
- pdfpwn.sh - ran on taget box, creates a cron that pulls and parses payload

## usage
- Upload setup.sh to target
- Run setup.sh (chmod +x setup.sh && ./setup.sh) and provide the full URL to the file containing the C2 commands (e.g. http://fqdn.domain.top/c2.txt)
- Administer the target box remotely by changing the contents of "c2.txt"

## how it works
### pdfgen
- checks for dependencies
- takes desired PDF name and bash commands as imput
- creates a new PDF with *convert* with the desired name
- encodes the bash commands in base64
- replaces the *ID* metatag data with the base64 encoded commands using regex

### pdfpwn
- checks for dependencies
- takes the URL for the PDF as input
- creates a cron that does the following
	- downloads the pdf, updating it if it already exists
	- calclates the md5 checksum for the pdf
	- runs *find* to locate the file (creates a time buffer between download and execution is different per file system, unless you have two identical file systems)
	- parses the base64 encoded commands, decodes and executes them
